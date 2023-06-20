#! /bin/sh

target="$HOME/git"

choice=$(find $target/* -maxdepth 0 -type d -printf "%f\n" | \
rofi \
-dmenu -i \
-p "Select project to run" \
-lines 10 \
-width 30)

if [ $? -ne 0 ]; then
    exit
fi

launch_path=$target/$choice/launch.sh
if [ -f $launch_path ]; then
    sh $launch_path &
else
    echo "No launch.sh file found in the project directory"
fi

code $target/$choice
