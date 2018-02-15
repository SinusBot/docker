#!/bin/sh

case "$1" in

"sinusbot")
	echo "Downloading SinusBot..."
	wget -qO - https://www.sinusbot.com/pre/sinusbot-0.13.37-f7e9ece.tar.bz2 | tar xj
	cp config.ini.dist config.ini
	sed -i "s|^TS3Path.*|TS3Path = \"\"|g" config.ini
	chmod +x sinusbot
	echo "Successfully downloaded SinusBot"
	;;
"youtube-dl")
	echo "Downloading youtube-dl..."
	wget -q https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
	chmod a+rx /usr/local/bin/youtube-dl
	sed -i 's/YoutubeDLPath = \"\"/YoutubeDLPath = \"\/usr\/local\/bin\/youtube-dl\"/g' config.ini
	echo "Successfully installed youtube-dl"
	;;
esac
