#!/bin/sh

DEVICE_NAME="ThinkPad Compact Bluetooth Keyboard with TrackPoint"

export DISPLAY=":0.0"
export XAUTHORITY="${1}"
export HOME="/home/$(echo ${XAUTHORITY} | /usr/bin/cut -d "/" -f 3)"

for i in $(seq 0 59)
do
  echo "$(/usr/bin/date) ${XAUTHORITY} ${HOME} ${i}" >> /tmp/trackpoint-adjuster.log
  if /usr/bin/xinput list | /usr/bin/grep -q "${DEVICE_NAME}"; then
    /usr/bin/xinput --set-prop "pointer:${DEVICE_NAME}" "libinput Accel Speed" ${TRACKPOINT_ADJUSTER_SPEED}
    break
  fi
  sleep 1
done
