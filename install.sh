#!/bin/bash

case "$1" in

"sinusbot")
	echo "Downloading SinusBot..."
	wget -qO - https://www.sinusbot.com/pre/sinusbot-0.13.37-f7e9ece.tar.bz2 | tar xj
	chmod +x sinusbot
	cp config.ini.dist config.ini
	sed -i "s|^TS3Path.*|TS3Path = \"\"|g" config.ini
	mv scripts scripts_org
	echo "Successfully downloaded SinusBot"
	;;
"teamspeak")
	echo "Installing TeamSpeak Client..."
	# Get latest TeamSpeak client version
	VERSION=$(wget -q -O - http://dl.4players.de/ts/releases/ | grep -Po '(?<=href=")[0-9]+(\.[0-9]+){2,3}(?=/")' | sort -Vr | head -1)

	# Download TeamSpeak client
	echo "Downloading TeamSpeak Client v$VERSION..."
	wget -q "http://dl.4players.de/ts/releases/$VERSION/TeamSpeak3-Client-linux_amd64-$VERSION.run"
	echo "Downloaded TeamSpeak Client"

	# Install TeamSpeak Client
	chmod +x TeamSpeak3-Client-linux_amd64-$VERSION.run
	yes | ./TeamSpeak3-Client-linux_amd64-$VERSION.run
	rm TeamSpeak3-Client-linux_amd64-$VERSION.run

	# Copy SinusBot plugin
	mkdir TeamSpeak3-Client-linux_amd64/plugins
	cp plugin/libsoundbot_plugin.so TeamSpeak3-Client-linux_amd64/plugins

	# Remove glx-integration lib
	rm TeamSpeak3-Client-linux_amd64/xcbglintegrations/libqxcb-glx-integration.so

	# Set the TS3PATH to the config.ini
	sed -i "s|^TS3Path.*|TS3Path = \"/opt/sinusbot/TeamSpeak3-Client-linux_amd64/ts3client_linux_amd64\"|g" config.ini
	echo "Successfully installed the TeamSpeak Client"
	;;
"youtube-dl")
	echo "Downloading youtube-dl..."
	wget -q https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
	chmod a+rx /usr/local/bin/youtube-dl
	echo 'YoutubeDLPath = "/usr/local/bin/youtube-dl"' >> config.ini
	echo "Successfully installed youtube-dl"
	;;
esac
