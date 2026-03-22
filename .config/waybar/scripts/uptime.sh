#!/bin/bash

# Считаем время
uptime_seconds=$(cat /proc/uptime | awk '{print int($1)}')
d=$((uptime_seconds / 86400))
h=$((uptime_seconds % 86400 / 3600))
m=$((uptime_seconds % 3600 / 60))

# Формируем многострочный текст
# \r используется для принудительного разрыва в некоторых версиях GTK
if [ $d -gt 0 ]; then
  text="${d}d\r${h}h\r${m}m"
else
  text="${h}h\r${m}m"
fi

# Выводим в формате JSON, который Waybar понимает лучше всего
echo "{\"text\": \"$text\", \"tooltip\": \"Uptime: ${d}d ${h}h ${m}m\"}"
