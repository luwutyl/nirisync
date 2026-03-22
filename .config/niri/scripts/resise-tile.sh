#!/bin/bash

if [ "$#" -ne 1]; then
  echo "ширина"
  exit 1
fi

WIDTH=$1

niri msg action set-window-width "$WIDTH"
