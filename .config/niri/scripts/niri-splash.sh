#!/bin/bash
sleep 0.8

# Путь к твоему видео
VIDEO="$HOME/.config/niri/scripts/start-an/video_2026-03-23_16-23-59.mp4"

# Запуск на мониторе LG (HDMI-A-2)
mpv --fs --no-osc --no-osd-bar --wayland-app-id="splashL" "$VIDEO" &

# Запуск на мониторе ASUS (HDMI-A-1)
mpv --fs --no-osc --no-osd-bar --wayland-app-id="splashR" "$VIDEO" &

# Ждем 16 секунд (или пока процессы сами закроются)
wait
