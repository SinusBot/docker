#!/bin/bash

case "$1" in

"sinusbot")
	echo "Downloading SinusBot..."
	curl -s https://www.sinusbot.com/pre/sinusbot-0.14.3-0e747fd.tar.bz2 | tar xj
	chmod 755 sinusbot
	mv scripts default_scripts
	ln -s data/private.dat private.dat
	cp config.ini.dist config.ini
	sed -i "s|^TS3Path.*|TS3Path = \"\"|g" config.ini
	echo "Successfully installed SinusBot"
	;;
"youtube-dl")
	echo "Downloading youtube-dl..."
	curl -s -L -o /usr/local/bin/youtube-dl https://yt-dl.org/downloads/latest/youtube-dl
	chmod 755 /usr/local/bin/youtube-dl
	echo 'YoutubeDLPath = "/usr/local/bin/youtube-dl"' >> config.ini
	echo "Successfully installed youtube-dl"
	;;
"teamspeak")
	echo "Installing TeamSpeak Client..."
	# Get latest TeamSpeak client download URL
	DOWNLOAD_URL=$(curl -s https://www.teamspeak.com/versions/client.json | jq -r '.linux.x86_64.mirrors["4Netplayers.de"]')

	# Download TeamSpeak client
	echo "Downloading TeamSpeak Client..."
	curl -s -o TeamSpeak3-Client-linux_amd64.run "$DOWNLOAD_URL"

	# Install TeamSpeak Client
	chmod 755 TeamSpeak3-Client-linux_amd64.run
	yes | ./TeamSpeak3-Client-linux_amd64.run
	rm TeamSpeak3-Client-linux_amd64.run

	# Copy SinusBot plugin
	mkdir TeamSpeak3-Client-linux_amd64/plugins
	cp plugin/libsoundbot_plugin.so TeamSpeak3-Client-linux_amd64/plugins

	# Remove glx-integration lib
	rm TeamSpeak3-Client-linux_amd64/xcbglintegrations/libqxcb-glx-integration.so

	# Set the TS3Path to the config.ini
	sed -i "s|^TS3Path.*|TS3Path = \"/opt/sinusbot/TeamSpeak3-Client-linux_amd64/ts3client_linux_amd64\"|g" config.ini
	echo "Successfully installed the TeamSpeak Client"
	;;
esac
