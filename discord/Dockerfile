FROM debian:buster-slim

LABEL description="SinusBot - Discord only image"
LABEL version="1.0.0-beta.16-ba60e37"

# Install dependencies and clean up afterwards
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ca-certificates bzip2 unzip curl python procps libpci3 libxslt1.1 libxkbcommon0 locales && \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

# Set locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

WORKDIR /opt/sinusbot

ADD install.sh .
RUN chmod 755 install.sh

# Download/Install SinusBot
RUN bash install.sh sinusbot

# Download/Install youtube-dl
RUN bash install.sh youtube-dl

# Download/Install Text-to-Speech
RUN bash install.sh text-to-speech

ADD entrypoint.sh .
RUN chmod 755 entrypoint.sh

EXPOSE 8087

VOLUME ["/opt/sinusbot/data", "/opt/sinusbot/scripts"]

ENTRYPOINT ["/opt/sinusbot/entrypoint.sh"]

HEALTHCHECK --interval=1m --timeout=10s \
  CMD curl --no-keepalive -f http://localhost:8087/api/v1/botId || exit 1
