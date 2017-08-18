#!/bin/bash

herbstclient fullscreen on
curl "wttr.in/$1"
read -n1 -rs
herbstclient fullscreen off
