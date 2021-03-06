#!/bin/sh
set -e -u -o pipefail

if [ -n "$KUBERNETES" ]; then
  echo "Enforce the Dev TUN opening."
  sh -c 'mkdir -p /dev/net && mknod /dev/net/tun c 10 200 && chmod 600 /dev/net/tun'
fi

if [ -n "$ENFORCE_DNS" ]; then
  echo "Enforce DNS servers."
  echo "nameserver $DNS1" > /etc/resolv.conf
  echo "nameserver $DNS2" >> /etc/resolv.conf
fi

runsvdir /app
