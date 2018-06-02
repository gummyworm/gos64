#!/bin/sh
# usage: <this.sh> input output width height 
convert -resize $3 $1 _tmp.png
stream -map rgba -depth 8 _tmp.png $2
