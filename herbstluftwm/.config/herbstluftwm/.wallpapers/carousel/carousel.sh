#!/bin/bash
picdir="$HOME/.config/herbstluftwm/.wallpapers/carousel/"

# One wallpaper a day I guess? :P
# This has to be the jankiest rng in history
seed=${1:-$(date +%d%m%y)}
idx=$(echo $seed | md5sum | cut -d" " -f1 | sed -e 's/[abcdef]//g;s/^0//')
idx=$(echo $((${idx:0:15} % $(find $picdir -name \*.jpg | wc -l))))
fname=$(find $picdir -name \*.jpg | sed -n "$((idx+1))p")

feh --bg-center $fname
