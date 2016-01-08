#!/bin/bash
# Author: Matthew Feickert
# Date: 2016-01-08
# Based on Alec's Web Log post "Convert video (.mp4 or other) to high quality animated gif"
# http://www.alecjacobson.com/weblog/?p=2102

# Check to make sure a file and frame rate were passed
if [ $# -eq 0 ]
then
    echo "A video file and frames per second rate are needed as input."
    exit 1
fi
if [ $# -eq 1 ]
then
    echo "A frames per second rate is needed as input."
    exit 1
fi
# Make dir to run script
mkdir video2gif_tmp
cp "$1" video2gif_tmp/
cd video2gif_tmp
# Do conversion from video to .gif
ffmpeg -i $1 -r $2 output%05d.png
convert output*.png output.gif
# Rename and move
filename=$(basename "$1")
filename="${filename%.*}"
cp output.gif ../"$filename".gif
# Cleanup
rm output*.png *.gif "$1"
cd ..
rmdir video2gif_tmp
