DIR=$1

mkdir $DIR
curl http://picam0.local:5000/takePhotoNow?delay=0 > $DIR/out0.jpg
curl http://picam1.local:5000/takePhotoNow?delay=0 > $DIR/out1.jpg
curl http://picam3.local:5000/takePhotoNow?delay=0 > $DIR/out2.jpg
curl http://picam2.local:5000/takePhotoNow?delay=0 > $DIR/out3.jpg
