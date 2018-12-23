#!/bin/bash

PID=0

if [ -d "default_scripts" ]; then
  mv default_scripts/* scripts
  rm -r default_scripts
  echo "Copied default scripts"
fi

echo "Updating youtube-dl..."
youtube-dl --restrict-filename -U
echo "youtube-dl was updated"

# graceful shutdown
kill_handler() {
  echo "Shutting down..."
  kill -s SIGINT -$(ps -o pgid= $PID | grep -o '[0-9]*')
  while [ -e /proc/$PID ]; do
    sleep .5
  done
  exit 0;
}

trap 'kill ${!}; kill_handler' SIGTERM # docker stop
trap 'kill ${!}; kill_handler' SIGINT  # CTRL + C

echo "Starting SinusBot..."
if [[ -v OVERRIDE_PASSWORD ]]; then
  echo "Overriding password..."
  ./sinusbot --override-password="${OVERRIDE_PASSWORD}" &
else
  ./sinusbot &
fi

PID=$!
echo "PID: $PID"

while true; do
  tail -f /dev/null & wait ${!}
done
