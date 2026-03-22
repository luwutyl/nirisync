#!/bin/bash

# Название окна/виджета в eww
WIDGET_NAME="clock"

# Проверяем, открыт ли виджет (ищем в списке активных окон eww)
if eww active-windows | grep -q "$WIDGET_NAME"; then
  eww close "$WIDGET_NAME"
else
  eww open "$WIDGET_NAME"
fi
