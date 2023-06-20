#! /usr/bin/env bash

flameshot &
picom &
nitrogen --restore &

# bar update script
$HOME/.config/dwm/bar.sh &

dwm
