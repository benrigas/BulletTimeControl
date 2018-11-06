#!/usr/local/bin/python

import numpy as np
import imutils
import cv2
import os
import sys

def shiftImage(image, x, y):
	os.system("/usr/local/bin/convert %s -page +%d+%d -background none -flatten %s" % (image, x, y, image))

actualCenter = (376,450)

f = open("/tmp/cameraCenters")
centers = []

for line in f:
	line = line.rstrip()
	centers.append(line.split(" "))

#print centers

captureDir = sys.argv[1]

for x in range(1,25):
	imageName = "%s/capture%d.jpg" % (captureDir, x)
	center = centers[x-1]
	diffX = actualCenter[0] - int(center[0])
	diffY = actualCenter[1] - int(center[1])
	print "Diff is %d, %d" % (diffX, diffY)
	shiftImage(imageName, diffX, diffY)

