#!/bin/bash

# Используем цикл, чтобы проверить все устройства, пока не найдем включенное
for file in /sys/class/leds/input*::capslock/brightness; do
  if [ -f "$file" ]; then
    status=$(cat "$file")
    if [ "$status" -ne 0 ]; then
      echo "Caps Lock"
      exit 0 # Нашли включенный — выходим
    fi
  fi
done

echo "" # Если ничего не нашли или всё выключено
