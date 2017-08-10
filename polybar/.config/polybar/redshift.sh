#!/bin/bash

icon=""
red="#d08770"
yellow="#ebcb8b"
blue="#8bc3eb"
gray="#707070"

pgrep -x redshift &>/dev/null
if [[ $? -eq 0 ]]; then
	temp=$(redshift -p 2>/dev/null | grep temperature | cut -d" " -f3)
	temp=${temp//K/}
fi

if [[ -z $temp ]]; then
	echo "%{F$gray}$icon"
elif [[ $temp -ge 5000 ]]; then
	echo "%{F$blue}$icon"
elif [[ $temp -ge 4000 ]]; then
	echo "%{F$yellow}$icon"
else
	echo "%{F$red}$icon"
fi

