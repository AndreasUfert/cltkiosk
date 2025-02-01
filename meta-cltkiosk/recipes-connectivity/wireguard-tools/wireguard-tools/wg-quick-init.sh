#!/bin/sh
### BEGIN INIT INFO
# Provides:          wg-quick
# Required-Start:    $network
# Required-Stop:     $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start WireGuard interface at boot
### END INIT INFO

case "$1" in
  start)
    echo "Starting WireGuard interface wg0..."
    /usr/bin/wg-quick up wg0
    ;;
  stop)
    echo "Stopping WireGuard interface wg0..."
    /usr/bin/wg-quick down wg0
    ;;
  restart)
    $0 stop
    $0 start
    ;;
  *)
    echo "Usage: $0 {start|stop|restart}"
    exit 1
    ;;
esac

exit 0
