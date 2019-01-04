FROM sinusbot/docker:discord

LABEL maintainer="Max Schmitt <max@schmitt.mx>"
LABEL description="Docker Image for the TeamSpeak 3 and Discord MusicBot called SinusBot."

# Install dependencies and clean up afterwards
RUN apt-get update && \
    apt-get install -y --no-install-recommends x11vnc xvfb libxcursor1 libnss3 libegl1-mesa libasound2 libglib2.0-0 libxcomposite-dev less jq && \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

# Download/Install TeamSpeak Client
RUN bash install.sh teamspeak
