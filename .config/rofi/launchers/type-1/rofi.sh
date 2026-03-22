#!/usr/bin/env bash

# Файл для хранения последнего пути
CacheFile="$HOME/.cache/last_wallpaper_dir"
# Временный файл для размытых обоев
BlurredWall="$HOME/.blurred_wallpaper.png"

# Определяем папку
if [ -f "$CacheFile" ]; then
  LastDir=$(cat "$CacheFile")
else
  LastDir=${1:-~/data/normalniy_foto/wallpaper/}
fi

# Команда выполнения:
# 1. swww ставит оригинал (с анимацией)
# 2. magick делает размытую копию (0x20 — сила размытия)
# 3. pkill убивает старый swaybg, чтобы запустить новый
# 4. swaybg ставит размытый фон
ExecCmd="bash -c ' \
  swww img --transition-duration 2 --transition-fps 60 --transition-type any \"\$1\"; \
  magick \"\$1\" -blur 0x15 \"$BlurredWall\"; \
  pkill swaybg; \
  swaybg -i \"$BlurredWall\" -m fill & \
  echo \"\$(dirname \"\$1\")\" > \"$CacheFile\" \
' --"

# Запуск Rofi
rofi -no-config \
  -theme ~/.config/rofi/launchers/type-1/style-wall.rasi \
  -show filebrowser \
  -filebrowser-command "$ExecCmd" \
  -filebrowser-directory "$LastDir" \
  -filebrowser-sorting-method mtime \
  -selected-row 1 >/dev/null
