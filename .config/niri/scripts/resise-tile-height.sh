#!/bin/bash

if [ "$#" -ne 1]; then
  echo "высота"
  exit 1
fi

WIDTH=$1

niri msg action set-window-height "$WIDTH"
