#!/bin/bash

# Название окна/виджета в eww
WIDGET_NAME="clock"
WIDGET_NAME1="clock1"

# Проверяем, открыт ли виджет (ищем в списке активных окон eww)
if eww active-windows | grep -q "$WIDGET_NAME"; then
  eww close "$WIDGET_NAME"
else
  eww open "$WIDGET_NAME"
fi

# Проверяем, открыт ли виджет (ищем в списке активных окон eww)
if eww active-windows | grep -q "$WIDGET_NAME1"; then
  eww close "$WIDGET_NAME1"
else
  eww open "$WIDGET_NAME1"
fi
