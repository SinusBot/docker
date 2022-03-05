FROM sinusbot/docker:1.0.0-beta.16-ba60e37-discord

LABEL description="SinusBot - TeamSpeak 3 and Discord music bot."
LABEL version="1.0.0-beta.17-ba60e37"

# Install dependencies and clean up afterwards
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends x11vnc xvfb libxcursor1 libnss3 libegl1-mesa libasound2 libglib2.0-0 libxcomposite-dev less jq python3 && \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

# Download/Install TeamSpeak Client
RUN bash install.sh teamspeak
