FROM sinusbot/docker:discord

LABEL maintainer="Max Schmitt <max@schmitt.mx>"
LABEL description="Docker Image for the Teamspeak 3 and Discord MusicBot called SinusBot."

RUN apt update \
    && apt install -y --no-install-recommends ca-certificates bzip2 less curl x11vnc xvfb libxcursor1 libnss3 libegl1-mesa libasound2 libglib2.0-0 python libxcomposite-dev jq procps \
    && apt -q clean all \
    && rm -rf /tmp/* /var/tmp/*

# Install TeamSpeak Client
RUN VERSION=$(curl -s https://www.teamspeak.com/versions/client.json | jq -r '.linux.x86_64.version') \

	# Download TeamSpeak client
	&& echo "Downloading TeamSpeak Client v$VERSION..." \
	&& curl -s -o TeamSpeak3-Client-linux_amd64.run "http://dl.4players.de/ts/releases/$VERSION/TeamSpeak3-Client-linux_amd64-$VERSION.run" \
	&& echo "Downloaded TeamSpeak Client" \

	# Install TeamSpeak Client
	&& chmod +x TeamSpeak3-Client-linux_amd64.run \
	&& yes | ./TeamSpeak3-Client-linux_amd64.run \
	&& rm TeamSpeak3-Client-linux_amd64.run \

	# Copy SinusBot plugin
	&& mkdir TeamSpeak3-Client-linux_amd64/plugins \
	&& cp plugin/libsoundbot_plugin.so TeamSpeak3-Client-linux_amd64/plugins \

	# Remove glx-integration lib
	&& rm TeamSpeak3-Client-linux_amd64/xcbglintegrations/libqxcb-glx-integration.so \

	# Set the TS3PATH to the config.ini
	&& sed -i "s|^TS3Path.*|TS3Path = \"/opt/sinusbot/TeamSpeak3-Client-linux_amd64/ts3client_linux_amd64\"|g" config.ini \
	&& echo "Successfully installed TeamSpeak Client"