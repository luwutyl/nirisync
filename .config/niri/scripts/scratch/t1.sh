#!/usr/bin/env bash

# ... (начало скрипта без изменений до блока анимации) ...

################################################################################
# Расчет динамических координат
################################################################################

get_geometry() {
  # Получаем геометрию сфокусированного монитора
  local monitor_geom=$(niri msg -j outputs | jq '.[] | select(.is_focused == true) | .logical')

  # Ширина, высота и отступы монитора
  MON_W=$(echo "$monitor_geom" | jq .width)
  MON_H=$(echo "$monitor_geom" | jq .height)

  # Ширина окна (можно задать фиксированную или брать % от экрана)
  WIN_W=1200
  WIN_H=800

  # Центрирование по X
  ANIM_XSET=$(((MON_W - WIN_W) / 2))
  # Спрятать за верхнюю границу (отрицательный Y)
  ANIM_OFFSET=$((-WIN_H - 100))
  # Позиция показа (центр по Y или сверху)
  ANIM_SHOW_Y=$(((MON_H - WIN_H) / 2))
}

moveWindowToScratchpad() {
  get_geometry

  niri msg action set-window-height --id "$win_id" "$WIN_H"
  niri msg action set-window-width --id "$win_id" "$WIN_W"
  niri msg action move-window-to-floating --id "$win_id"

  # Выезжает вверх
  niri msg action move-floating-window --id "$win_id" -x $ANIM_XSET -y $ANIM_OFFSET

  sleep $ANIM_DELAY

  niri msg action move-window-to-workspace \
    --window-id "$win_id" "$SCRATCH_WORKSPACE_NAME" \
    --focus=false
}

bringScratchpadWindowToFocus() {
  get_geometry

  # Перемещаем на текущий монитор и воркспейс
  niri msg action move-window-to-monitor --id "$win_id" "$output_id"
  niri msg action move-window-to-workspace --window-id "$win_id" "$work_idx"

  niri msg action move-window-to-floating --id "$win_id"
  niri msg action set-window-height --id "$win_id" "$WIN_H"
  niri msg action set-window-width --id "$win_id" "$WIN_W"

  # Ставим в начальную точку анимации (над экраном)
  niri msg action move-floating-window --id "$win_id" -x $ANIM_XSET -y $ANIM_OFFSET

  sleep 0.02

  # Плавно (насколько позволяет niri) перемещаем в центр
  niri msg action move-floating-window --id "$win_id" -x $ANIM_XSET -y $ANIM_SHOW_Y
  niri msg action focus-window --id "$win_id"
}

# ... (остальная часть main logic без изменений) ...
