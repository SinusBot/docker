#!/bin/bash

set -e

case "$1" in

"sinusbot")
	echo "Downloading SinusBot..."
	curl -s https://www.sinusbot.com/pre/sinusbot-1.0.0-alpha.4-311d85f.tar.bz2 | tar xj
	chmod 755 sinusbot
	mv scripts default_scripts
	ln -s data/private.dat private.dat
	cp config.ini.dist config.ini.configured
	sed -i "s|^TS3Path.*|TS3Path = \"\"|g" config.ini.configured

	cd tts

	mkdir tmp
	cd tmp
	curl -s https://chromium.googlesource.com/chromiumos/platform/assets/+archive/master/speech_synthesis/patts.tar.gz | tar -xz
	unzip -q tts_service_x86_64.nexe.zip

	mv tts_service_x86_64.nexe ..
	mv voice_lstm_en-US.zvoice ..
	mv voice_lstm_de-DE.zvoice ..

	cd ..
	rm -rf tmp

	echo "Successfully installed SinusBot"
	;;
"youtube-dl")
	echo "Downloading youtube-dl..."
	curl -s -L -o /usr/local/bin/youtube-dl https://yt-dl.org/downloads/latest/youtube-dl
	chmod 755 /usr/local/bin/youtube-dl
	echo 'YoutubeDLPath = "/usr/local/bin/youtube-dl"' >> config.ini.configured
	echo "Successfully installed youtube-dl"
	;;
"teamspeak")
	echo "Installing TeamSpeak Client..."
	# Get latest TeamSpeak client download URL
	DOWNLOAD_URL=$(curl -s https://www.teamspeak.com/versions/client.json | jq -r '.linux.x86_64.mirrors["teamspeak.com"]')

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
	sed -i "s|^TS3Path.*|TS3Path = \"/opt/sinusbot/TeamSpeak3-Client-linux_amd64/ts3client_linux_amd64\"|g" config.ini.configured
	echo "Successfully installed the TeamSpeak Client"
	;;
esac
