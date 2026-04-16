#!/bin/bash

# Fichier de destination dans Pictures avec date/heure
DEST="$HOME/Pictures/Screenshot_$(date +%F_%H-%M-%S).png"

# Sélection de la zone et capture avec grim
grim -g "$(slurp)" "$DEST"

# Ouvrir Swappy pour annoter
swappy "$DEST"
