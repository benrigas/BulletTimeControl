#!/bin/bash

cd $1

ffmpeg -i capture.gif -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" capture.mp4
