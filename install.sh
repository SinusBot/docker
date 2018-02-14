#!/bin/sh

case "$1" in

"teamspeak")
	echo "Installing teamspeak..."
	# Getting the latest TeamSpeak client version
	VERSION=$(wget -q -O - http://dl.4players.de/ts/releases/ | grep -Po '(?<=href=")[0-9]+(\.[0-9]+){2,3}(?=/")' | sort -Vr | head -1)
	echo "Downloading teamspeak version: $VERSION"
	DOWNLOAD_URL="http://dl.4players.de/ts/releases/$VERSION/TeamSpeak3-Client-linux_amd64-$VERSION.run"
	# Downloading latest Teamspeak client
	wget -q $DOWNLOAD_URL
	echo "Downloaded teamspeak client"
	chmod +x ./TeamSpeak3-Client-linux_amd64-$VERSION.run
	yes | ./TeamSpeak3-Client-linux_amd64-$VERSION.run
	rm ./TeamSpeak3-Client-linux_amd64-$VERSION.run
	echo "Installed teamspeak client"
	# Copy the plugin
	mkdir TeamSpeak3-Client-linux_amd64/plugins
	cp plugin/libsoundbot_plugin.so TeamSpeak3-Client-linux_amd64/plugins
	# Removing the glx-integration lib
	rm TeamSpeak3-Client-linux_amd64/xcbglintegrations/libqxcb-glx-integration.so
	echo "Succeed in installing the teamspeak client"
	;;
"youtube-dl")
	echo "Downloading youtube-dl..."
	wget -q https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
	chmod a+rx /usr/local/bin/youtube-dl
	sed -i 's/YoutubeDLPath = \"\"/YoutubeDLPath = \"\/usr\/local\/bin\/youtube-dl\"/g' /opt/ts3soundboard/config.ini
	echo "Succeed in installing youtube-dl"
	;;
esac
