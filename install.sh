#!/bin/sh

case "$1" in

"sinusbot")
	echo "Downloading SinusBot..."
	wget -qO - https://www.sinusbot.com/pre/sinusbot-0.13.37-f7e9ece.tar.bz2 | tar xj
    cp config.ini.dist config.ini
    chmod +x /opt/ts3soundboard/sinusbot
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
	chmod +x ./TeamSpeak3-Client-linux_amd64-$VERSION.run
	yes | ./TeamSpeak3-Client-linux_amd64-$VERSION.run
	rm ./TeamSpeak3-Client-linux_amd64-$VERSION.run

	# Copy SinusBot plugin
	mkdir TeamSpeak3-Client-linux_amd64/plugins
	cp plugin/libsoundbot_plugin.so TeamSpeak3-Client-linux_amd64/plugins

	# Remove glx-integration lib
	rm TeamSpeak3-Client-linux_amd64/xcbglintegrations/libqxcb-glx-integration.so
	echo "Successfully installed the TeamSpeak Client"
	;;
"youtube-dl")
	echo "Downloading youtube-dl..."
	wget -q https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
	chmod a+rx /usr/local/bin/youtube-dl
	sed -i 's/YoutubeDLPath = \"\"/YoutubeDLPath = \"\/usr\/local\/bin\/youtube-dl\"/g' /opt/ts3soundboard/config.ini
	echo "Successfully installed youtube-dl"
	;;
esac
