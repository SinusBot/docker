#!/bin/bash

set -e

case "$1" in

"yt-dlp")
	echo "Downloading yt-dlp..."
	curl -s -L -o /usr/local/bin/yt-dlp https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp
	chmod 755 /usr/local/bin/yt-dlp
	echo "Successfully installed yt-dlp"
	;;

esac
