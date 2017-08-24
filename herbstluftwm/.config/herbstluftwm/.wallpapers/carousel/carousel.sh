#!/bin/bash
picdir="$HOME/.config/herbstluftwm/.wallpapers/carousel/"

# One wallpaper a day I guess? :P
# This has to be the jankiest rng in history
idx=$(date +%d%m%y | md5sum | cut -d" " -f1)
idx=$(echo $(("0x$idx" % $(find $picdir -name \*.jpg | wc -l))))
fname=$(find $picdir -name \*.jpg | sed -n "${idx+1}p")

feh --bg-center $fname
