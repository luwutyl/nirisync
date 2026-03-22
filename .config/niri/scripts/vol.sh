#!/bin/sh

SINK="@DEFAULT_AUDIO_SINK@"

VOLUME=$(wpctl get-volume $SINK | awk '{print int($2 * 100)}')
MUTED=$(wpctl get-volume $SINK | grep -o '\[MUTED\]')

if [ -n "$MUTED" ]; then
  notify-send -h string:x-canonical-private-synchronous:volume \
    -u low -i audio-volume-muted "  Muted"
  exit 0
fi

notify-send -h int:value:$VOLUME \
  -h string:x-canonical-private-synchronous:volume \
  -u low -i audio-volume-high "Volume: $VOLUME%"
