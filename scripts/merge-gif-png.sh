#!/bin/sh

convert -layers composite $1 null: $2 -layers optimize -gravity center $3
