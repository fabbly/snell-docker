#!/bin/sh

SNELL="/usr/local/bin/snell-server"
CONF="/etc/snell/snell-server.conf"

run() {
  if [ -f ${CONF} ]; then
    echo "Using existing config..."
  else
    if [ -z ${PSK} ]; then
      PSK=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 31)
      echo "Using generated PSK: ${PSK}"
    else
      echo "Using predefined PSK: ${PSK}"
    fi
    echo "Generating new config..."
    if [ ! -d "/etc/snell/" ]; then
    mkdir /etc/snell/
    fi
    echo "[snell-server]" >> ${CONF}
    echo "listen = ${SERVER_HOST}:${SERVER_PORT}" >> ${CONF}
    echo "psk = ${PSK}" >> ${CONF}
    echo "obfs = ${OBFS}" >> ${CONF}
  fi
  ${SNELL} -c ${CONF} ${ARGS}
}
if [ -z "$@" ]; then
  run
else
  exec "$@"
fi