FROM sinusbot/docker:discord

LABEL maintainer="Max Schmitt <max@schmitt.mx>"
LABEL description="Docker Image for the Teamspeak 3 and Discord MusicBot called SinusBot."

RUN apt update \
    && apt install -y --no-install-recommends x11vnc xvfb libxcursor1 libnss3 libegl1-mesa libasound2 libglib2.0-0 libxcomposite-dev jq procps \
    && apt -q clean all \
    && rm -rf /tmp/* /var/tmp/*

# Download/Install TeamSpeak Client
RUN bash install.sh teamspeak