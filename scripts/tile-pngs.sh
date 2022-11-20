#!/bin/sh
set -e

ffmpeg -stream_loop 1 -i 00%02d.png -c:v png test.mov 
ffmpeg -i test.mov -pix_fmt rgba -vf "format=rgba,select=not(mod(n\,1)),scale=128:128,tile=4x4" -frames:v 1 tile.png
