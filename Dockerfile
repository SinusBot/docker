FROM sinusbot/docker:1.0.0-beta.14-dc94a7c-discord

LABEL description="SinusBot - TeamSpeak 3 and Discord music bot."
LABEL version="1.0.0-beta.14-dc94a7c"

# Install dependencies and clean up afterwards
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends x11vnc xvfb libxcursor1 libnss3 libegl1-mesa libasound2 libglib2.0-0 libxcomposite-dev less jq && \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

# Download/Install TeamSpeak Client
RUN bash install.sh teamspeak
