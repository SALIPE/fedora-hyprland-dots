#!/bin/bash

INTERNAL="eDP-1"   # nome da tela interna — veja com: hyprctl monitors
EXTERNAL="HDMI-A-2" # substitua pelo nome do seu monitor externo

LID_STATE_FILE="/proc/acpi/button/lid/LID0/state"

while true; do
    LID_STATE=$(grep -o "open\|closed" "$LID_STATE_FILE")

    if [[ "$LID_STATE" == "closed" ]]; then
        # Desliga tela do notebook
        hyprctl keyword monitor "$INTERNAL, disable"
        hyprctl keyword monitor "$EXTERNAL, preferred"
    else
        # Liga tela do notebook quando abrir
        hyprctl reload
    fi

    sleep 1
done

