#!/bin/bash

cd $1

/usr/local/bin/ffmpeg -r 9 -i capture%d.jpg -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" capture.mp4

