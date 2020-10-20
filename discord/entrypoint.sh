#!/bin/bash

# print kernel/system info
uname -srmo
date

if [ -d "default_scripts" ]; then
  mv default_scripts/* scripts
  rm -r default_scripts
  echo "Copied default scripts"
fi

if [ ! -f "data/config.ini" ]; then
  cp config.ini.configured data/config.ini
fi

ln -fs data/config.ini config.ini

SINUSBOT="./sinusbot"
YTDL="youtube-dl"

echo "Updating youtube-dl..."
$YTDL --restrict-filename -U
$YTDL --version

PID=0

# graceful shutdown on kill
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

if [[ -v UID ]] || [[ -v GID ]]; then
  # WORKAROUND for `setpriv: libcap-ng is too old for "all" caps`, previously "-all" was used here
  # create a list to drop all capabilities supported by current kernel
  cap_prefix="-cap_"
  caps="$cap_prefix$(seq -s ",$cap_prefix" 0 $(cat /proc/sys/kernel/cap_last_cap))"

  SETPRIV="setpriv --clear-groups --inh-caps=$caps"

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
  YTDL="$SETPRIV $YTDL"
fi

echo "Clearing youtube-dl cache..."
$YTDL --rm-cache-dir

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
