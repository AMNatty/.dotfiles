#!/bin/sh

set -e

cd "$(dirname "$0")"

palette="palette.png"

filters="fps=20,scale=-1:360:flags=lanczos"

file="$1"

ffmpeg -v warning -i "$file" -vf "$filters,palettegen" -y "$palette"
ffmpeg -v warning -i "$file" -i "$palette" -lavfi "$filters [x]; [x][1:v] paletteuse" -y "${file%.*}.gif"
rm $palette
