FROM debian:stretch-slim

LABEL maintainer="Max Schmitt <max@schmitt.mx>"
LABEL description="SinusBot Docker Image for Discord only."

# install dependencies and clean up afterwards
RUN apt update && \
    apt install -y --no-install-recommends ca-certificates bzip2 curl python && \
    apt -q clean all && \
    rm -rf /tmp/* /var/tmp/*

WORKDIR /opt/sinusbot

ADD install.sh .
RUN chmod 755 install.sh

# Download/Install SinusBot
RUN bash install.sh sinusbot

# Download/Install youtube-dl
RUN bash install.sh youtube-dl

ADD entrypoint.sh .
RUN chmod 755 entrypoint.sh

EXPOSE 8087

VOLUME ["/opt/sinusbot/data", "/opt/sinusbot/scripts"]

ENTRYPOINT ["/opt/sinusbot/entrypoint.sh"]

HEALTHCHECK --interval=1m --timeout=5s \
  CMD curl -f http://localhost:8087/api/v1/botId || exit 1