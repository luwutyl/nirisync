#!/bin/bash
CONFIG="$HOME/.config/niri/config.kdl"

# Проверяем текущее значение в файле
if grep -q 'center-focused-column "always"' "$CONFIG"; then
  # Меняем на "never"
  sed -i 's/center-focused-column "always"/center-focused-column "never"/' "$CONFIG"
else
  # Меняем на "always"
  sed -i 's/center-focused-column "never"/center-focused-column "always"/' "$CONFIG"
fi

# Принудительная перезагрузка (хотя niri часто подхватывает изменения сам)
niri msg action load-config-file
