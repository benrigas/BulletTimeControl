#!/usr/local/bin/python

import numpy as np
import imutils
import cv2
import os
import sys
import time
import subprocess

def shiftImage(image, x, y):
	#os.system("/usr/local/bin/convert %s -page +%d+%d -background none -flatten %s" % (image, x, y, image))
	#pid = os.spawnlp(os.P_NOWAIT, "/usr/local/bin/convert %s -page +%d+%d -background none -flatten %s" % (image, x, y, image))
	#print "PID is " + str(pid)
	#os.waitpid(pid, 0)
	
	command = "/usr/local/bin/convert"
	args = "%s -page +%d+%d -background none -flatten %s" % (image, x, y, image)
	pipe = subprocess.Popen([command, image, "-page", "+%d+%d" % (x,y), "-background", "none", "-flatten", image], 0)
	return pipe
	#pipe = subprocess.Popen("/usr/local/bin/convert %s -page +%d+%d -background none -flatten %s" % (image, x, y, image), 0)
	#pipe.wait()

actualCenter = (360,450)

f = open("/tmp/cameraCenters")
centers = []

for line in f:
	line = line.rstrip()
	centers.append(line.split(" "))

#print centers

captureDir = sys.argv[1]
pipes = []

for x in range(1,25):
	imageName = "%s/capture%d.jpg" % (captureDir, x)
	center = centers[x-1]
	diffX = actualCenter[0] - int(center[0])
	diffY = actualCenter[1] - int(center[1])
	print "Diff is %d, %d" % (diffX, diffY)
	pipe = shiftImage(imageName, diffX, diffY)
	pipes.append(pipe)

for pipe in pipes:
	pipe.wait()

