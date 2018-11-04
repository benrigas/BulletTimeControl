#!/usr/bin/env python

import numpy as np
import imutils
import cv2
import os

def get_image_center(image_file):
	image = cv2.imread(image_file)

	redLower = (0, 0, 200)
	redUpper = (0, 40, 255)

	# find the colors within the specified boundaries and apply
	# the mask
	mask = cv2.inRange(image, redLower, redUpper)
	output = cv2.bitwise_and(image, image, mask = mask)

	# find contours in the mask and initialize the current
	# (x, y) center of the ball
	cnts = cv2.findContours(mask.copy(), cv2.RETR_EXTERNAL,
	cv2.CHAIN_APPROX_SIMPLE)
	cnts = cnts[0] if imutils.is_cv2() else cnts[1]
	center = None
	frame = image
	# only proceed if at least one contour was found
	if len(cnts) > 0:
		# find the largest contour in the mask, then use
		# it to compute the minimum enclosing circle and
		# centroid
		c = max(cnts, key=cv2.contourArea)
		((x, y), radius) = cv2.minEnclosingCircle(c)
		M = cv2.moments(c)
		center = (int(M["m10"] / M["m00"]), int(M["m01"] / M["m00"]))

		# only proceed if the radius meets a minimum size
		if radius > 10:
			# draw the circle and centroid on the frame,
			# then update the list of tracked points
			cv2.circle(frame, (int(x), int(y)), int(radius),
				(0, 255, 255), 2)
			cv2.circle(frame, center, 5, (0, 0, 255), -1)

	print "Center is %s" % (center,)
	# show the images
	#cv2.imshow("images", np.hstack([image, output]))
	#cv2.waitKey(0)
	return center

def shiftImage(image, x, y):
	os.system("convert img/%s -page +%d+%d -background none -flatten imgnew/%s" % (image, x, y, image))

actualCenter = (376,450)

for x in range(24):
	imageName = "capture%d.jpg" % (x)
	center = get_image_center("img/%s" % (imageName))
	diffX = actualCenter[0] - center[0]
	diffY = actualCenter[1] - center[1]
	print "Diff is %d, %d" % (diffX, diffY)
	shiftImage(imageName, diffX, diffY)

