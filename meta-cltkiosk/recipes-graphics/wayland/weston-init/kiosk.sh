#!/bin/sh

VPN_HOST="192.168.178.35"

# wait for IP to become available
while ! ping -c 1 -W 1 $VPN_HOST > /dev/null 2>&1; do
  sleep 1
done

export XDG_CACHE_HOME=/tmp/weston/.cache
export XDG_DATA_HOME=/tmp/weston/.local/share
export XDG_CONFIG_HOME=/tmp/weston/.config
export XDG_STATE_HOME=/tmp/weston/.local/state

mkdir -p /tmp/weston/.cache
mkdir -p /tmp/weston/.local/share
mkdir -p /tmp/weston/.config
mkdir -p /tmp/weston/.local/state

chown -R weston:weston /tmp/weston

eval $(dbus-launch --sh-syntax --exit-with-session)
export DBUS_SESSION_BUS_ADDRESS
export DBUS_SESSION_BUS_PID

/usr/bin/epiphany --private-instance http://192.168.178.35:11090/discon/tft-display
