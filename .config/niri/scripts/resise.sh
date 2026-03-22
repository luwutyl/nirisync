#!/bin/bash

# Проверяем наличие двух аргументов
if [ "$#" -ne 2 ]; then
  echo "Использование: $0 ширина высота"
  exit 1
fi

WIDTH=$1
HEIGHT=$2

#niri msg action toggle-window-floating

# Изменяем размер активного окна
niri msg action set-window-width "$WIDTH"
niri msg action set-window-height "$HEIGHT"

# Центрируем окно
niri msg action center-column
