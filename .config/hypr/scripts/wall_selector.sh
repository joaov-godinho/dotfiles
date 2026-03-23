#!/bin/bash

# 1. Pasta dos wallpapers
WALL_DIR="$HOME/Imagens/Wallpapers"

# 2. Lista os arquivos e manda para o Rofi exibir com ícones
selected=$(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | sort | while read -r img; do
    echo -en "$(basename "$img")\0icon\x1f$img\n"
done | rofi -dmenu -i -show-icons \
    -theme-str 'window { width: 900px; children: [ "mainbox" ]; }' \
    -theme-str 'listview { columns: 3; lines: 3; spacing: 15px; }' \
    -theme-str 'element { orientation: vertical; padding: 15px; }' \
    -theme-str 'element-icon { size: 160px; }' \
    -theme-str 'element-text { horizontal-align: 0.5; }' \

# Wallpaper selector no formato de lista
#   -theme-str 'window { width: 600px; children: [ "mainbox" ]; }' \
#   -theme-str 'listview { columns: 1; lines: 8; spacing: 5px; }' \
#   -theme-str 'element { orientation: horizontal; padding: 8px; }' \
#   -theme-str 'element-icon { size: 48px; }' \
#   -theme-str 'element-text { vertical-align: 0.5; margin: 0 10px; }' \

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

# Salva a imagem atual para renderizar na tela de de login e no Rofi
#cp "$TARGET_WALL" ~/.cache/current_wallpaper.sudo
cp "$TARGET_WALL" ~/.cache/current_wallpaper.png
#magick "$TARGET_WALL" -resize x500 -gravity Center -extent 300x500 ~/.cache/rofi_wallpaper.png
sudo /usr/local/bin/update-sddm-wallpaper "$TARGET_WALL"

# 3. Força a primeira cor principal sem pedir confirmação
matugen image "$TARGET_WALL" --source-color-index 0

# 4. Recarrega a Waybar, Kitty e swaync
pkill waybar; sleep 0.5 && waybar & disown
killall -SIGUSR1 kitty
pkill swaync && swaync &
