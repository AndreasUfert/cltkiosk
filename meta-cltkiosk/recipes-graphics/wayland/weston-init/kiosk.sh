#!/bin/sh

BACKEND_NETWORK="192.168.178.0/24"
BACKEND="http://192.168.178.35:12345/cltkiosk"

# wait for backend network to become available
while ! /sbin/ip route | grep -q "^$BACKEND_NETWORK "; do
  echo "Waiting for backend network..."
  sleep 2
done

# handle read-only home directory
export XDG_CACHE_HOME=/tmp/weston/.cache
export XDG_DATA_HOME=/tmp/weston/.local/share
mkdir -p /tmp/weston/.cache
mkdir -p /tmp/weston/.local/share
chown -R weston:weston /tmp/weston

# start browser, fullscreen/kiosk is handled by weston
/usr/bin/cog --webprocess-failure=restart "$BACKEND"