#!/bin/bash

if [ -d "default_scripts" ]; then
  mv default_scripts/* scripts
  rm -r default_scripts
  echo "Copied default scripts"
fi

if [ ! -f "data/config.ini" ]; then
  cp config.ini.configured data/config.ini
fi

ln -fs data/config.ini config.ini

echo "Updating youtube-dl..."
youtube-dl --restrict-filename -U

echo "Clearing youtube-dl Cache..."
youtube-dl --rm-cache-dir

PID=0

# graceful shutdown
kill_handler() {
  echo "Shutting down..."
  kill -s SIGINT -$(ps -o pgid= $PID | grep -o '[0-9]*')
  while [ -e /proc/$PID ]; do
    sleep .5
  done
  exit 0
}

trap 'kill ${!}; kill_handler' SIGTERM # docker stop
trap 'kill ${!}; kill_handler' SIGINT  # CTRL + C

SINUSBOT="./sinusbot"

if [[ -v UID ]] || [[ -v GID ]]; then
  SETPRIV="setpriv --clear-groups --inh-caps=-all"

  # set user id
  if [[ -v UID ]]; then
    echo "User ID: $UID"
    SETPRIV="$SETPRIV --reuid=$UID"
    echo "Change file owner..."
    chown -R "$UID" "$PWD"
  fi
  # set group id
  if [[ -v GID ]]; then
    echo "Group ID: $GID"
    SETPRIV="$SETPRIV --regid=$GID"
    echo "Change file group..."
    chown -R ":$GID" "$PWD"
  fi
  echo "Drop privileges..."
  SINUSBOT="$SETPRIV $SINUSBOT"
fi

echo "Starting SinusBot..."
if [[ -v OVERRIDE_PASSWORD ]]; then
  echo "Overriding password..."
  $SINUSBOT --override-password="${OVERRIDE_PASSWORD}" &
else
  $SINUSBOT &
fi

PID=$!
echo "PID: $PID"

while true; do
  tail -f /dev/null & wait ${!}
done
