#!/bin/sh

DEVICE_NAME_BT="ThinkPad Compact Bluetooth Keyboard with TrackPoint"
DEVICE_NAME_USB="ThinkPad Compact USB Keyboard with TrackPoint"

export DISPLAY=":0.0"
export XAUTHORITY="${1:-${XAUTHORITY}}"
export HOME="/home/$(echo ${XAUTHORITY} | /usr/bin/cut -d "/" -f 3)"

for i in $(seq 0 59)
do
  echo "$(/usr/bin/date) ${XAUTHORITY} ${HOME} ${i}" >> /tmp/trackpoint-adjuster.log
  if /usr/bin/xinput list | /usr/bin/grep -q "${DEVICE_NAME_BT}"; then
    /usr/bin/xinput --set-prop "pointer:${DEVICE_NAME_BT}" "libinput Accel Speed" ${TRACKPOINT_ADJUSTER_SPEED}
    break
  fi
  if /usr/bin/xinput list | /usr/bin/grep -q "${DEVICE_NAME_USB}"; then
    /usr/bin/xinput --set-prop "pointer:${DEVICE_NAME_USB}" "libinput Accel Speed" ${TRACKPOINT_ADJUSTER_SPEED}
    break
  fi
  sleep 1
done
