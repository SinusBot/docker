#!/bin/bash

PID=0

if [ ! -f ".docker-scripts-copied" ]; then
  mv scripts_org/* scripts
  rm -r scripts_org
  touch .docker-scripts-copied
  echo "Copied original scripts to the volume"
fi

echo "Updating youtube-dl..."
youtube-dl --restrict-filename -U
echo "youtube-dl updated"

# SIGTERM (docker stop) and SIGINT (when you press CTRL + C) handler
kill_handler() {
  echo "Shutting down..."
  kill -s SIGINT -$(ps -o pgid= $PID | grep -o '[0-9]*')
  while [ -e /proc/$PID ]; do
    sleep .5
  done
  exit 0;
}

trap 'kill ${!}; kill_handler' SIGTERM
trap 'kill ${!}; kill_handler' SIGINT

echo "Starting SinusBot..."
if [[ -v "${OVERRIDE_PASSWORD}" ]]; then
  echo "Using the --override-password flag"
  ./sinusbot --override-password="${OVERRIDE_PASSWORD}" &
else
  ./sinusbot &
fi

PID=$!

echo "PID: $PID"

while true; do
   tail -f /dev/null & wait ${!}
done
