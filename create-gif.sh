#!/bin/bash

pushd $1
/usr/local/bin/ffmpeg -f image2 -framerate 9 -i capture%d.jpg capture.gif
popd
