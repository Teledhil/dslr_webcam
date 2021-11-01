#!/bin/bash

export XAUTHORITY=/home/teledhil/.Xauthority
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

PID_FILE=/run/dslr.pid

notify() {
  local header=$1
  local text=$2

  su teledhil -c "notify-send -i camera-web '$header' '$text'"
}

notify "Camera detected" "Waiting 10 seconds for camera to be ready"
sleep 10

notify "Starting stream" "It takes a few seconds for the stream to start"
# -hwaccel qsv \
# -c:v mjpeg_qsv \
gphoto2 --stdout --capture-movie --frames=30 --capture-sound | ffmpeg \
  -hwaccel nvdec \
  -c:v mjpeg_cuvid \
  -i - \
  -vcodec rawvideo \
  -pix_fmt yuv420p \
  -threads 0 \
  -filter:v fps=30 \
  -f v4l2 /dev/video0 &> /tmp/dslr.log

notify "Stream stopped" "Reconnect the camera to stream again"
