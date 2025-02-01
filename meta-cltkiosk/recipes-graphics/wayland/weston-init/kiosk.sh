#!/bin/sh

BACKEND="http://192.168.178.35:12345/cltkiosk"

# wait for backend to become available
while ! /bin/busybox wget -q --spider "$BACKEND"; do
  sleep 1
done

# handle read-only home directory
export XDG_CACHE_HOME=/tmp/weston/.cache
export XDG_DATA_HOME=/tmp/weston/.local/share
mkdir -p /tmp/weston/.cache
mkdir -p /tmp/weston/.local/share
chown -R weston:weston /tmp/weston

# start browser, fullscreen/kiosk is handled by weston
/usr/bin/cog --webprocess-failure=restart "$BACKEND"