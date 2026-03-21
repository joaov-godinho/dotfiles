#!/bin/bash

# 1. Pasta dos wallpapers
WALL_DIR="$HOME/Imagens/Wallpapers"

# 2. Lista os arquivos e manda para o Rofi exibir com ícones
selected=$(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | while read -r img; do
    echo -en "$(basename "$img")\0icon\x1f$img\n"
done | rofi -dmenu -i -show-icons \
    -theme-str 'window { width: 900px; children: [ "mainbox" ]; }' \
    -theme-str 'listview { columns: 3; lines: 3; spacing: 15px; }' \
    -theme-str 'element { orientation: vertical; padding: 15px; }' \
    -theme-str 'element-icon { size: 160px; }' \
    -theme-str 'element-text { horizontal-align: 0.5; }' \
    -p "Wallpapers")

# Se apertar Esc o script para
if [ -z "$selected" ]; then
    exit 0
fi

# Caminho completo do wallpaper selecionado
TARGET_WALL="$WALL_DIR/$selected"

# 1. Descobre em qual monitor o foco está
FOCUSED_MONITOR=$(hyprctl activeworkspace | awk -F 'monitor ' '{print $2}' | awk '{print $1}' | tr -d ':')

# 2. Aplica o wallpaper APENAS no monitor focado
swww img "$TARGET_WALL" -o "$FOCUSED_MONITOR" --transition-type grow --transition-pos 0.5,0.5 --transition-step 90

# EXTRA: Salva a imagem atual para o seu Fastfetch renderizar no Kitty
cp "$TARGET_WALL" ~/.cache/current_wallpaper.png

# 3. MÁGICA SILENCIOSA: Força a primeira cor principal sem pedir confirmação
matugen image "$TARGET_WALL" --source-color-index 0

# 4. Recarrega a Waybar
pkill waybar; sleep 0.5 && waybar & disown

# 5. Recarrega o Kitty
killall -SIGUSR1 kitty

