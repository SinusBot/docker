#!/bin/bash

if [ ! -f ".docker-scripts-copied" ]; then
  mv scripts_org/* scripts
  rm -r scripts_org
  touch .docker-scripts-copied
  echo "Copied original scripts to the volume"
fi

echo "Updating youtube-dl..."
youtube-dl --restrict-filename -U
echo "youtube-dl updated"

echo "Starting SinusBot..."
if [[ -v "${OVERRIDE_PASSWORD}" ]]; then
  echo "Using the --override-password flag"
  ./sinusbot --override-password="${OVERRIDE_PASSWORD}"
else
  ./sinusbot
fi