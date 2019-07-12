#!/bin/sh

ls -1 /home/*/.Xauthority | /usr/bin/parallel /opt/trackpoint-adjuster/apply.sh "{}"
