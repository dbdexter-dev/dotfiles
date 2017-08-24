#!/bin/bash
tmpbg=/tmp/screen.png
overlay=~/.config/herbstluftwm/lock.png
res=1920x1080

ffmpeg -f x11grab -video_size $res -y -i $DISPLAY -i $overlay -filter_threads 4 -filter_complex "boxblur=8:8,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -vframes 1 $tmpbg
i3lock --textcolor=ffffff00 --insidecolor=ffffff1c --ringcolor=ffffff3e --linecolor=ffffff00 --keyhlcolor=00000080 --ringvercolor=00000000 --insidevercolor=0000001c --ringwrongcolor=00000055 --insidewrongcolor=0000001c -i $tmpbg

