#!/bin/sh

title=$(playerctl metadata xesam:title 2>/dev/null)
album=$(playerctl metadata xesam:album 2>/dev/null)
artist=$(playerctl metadata xesam:artist 2>/dev/null)
art=$(playerctl metadata mpris:artUrl 2>/dev/null | sed 's|file://||')

# Если обложки нет — убираем иконку
if [ -f "$art" ]; then
  icon="-i $art"
else
  icon=""
fi

notify-send \
  -a "Media" \
  -u low \
  -t 5000 \
  -h string:x-canonical-private-synchronous:media \
  $icon \
  "   $title" \
  "Album:  $album\nArtist: $artist"
