FROM debian:stretch-slim

LABEL maintainer="Max Schmitt <max@schmitt.mx>"
LABEL description="SinusBot Docker Image for Discord only."

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates bzip2 wget python && \
    apt-get -q clean all && \
    rm -rf /tmp/* /var/tmp/*

WORKDIR /opt/sinusbot

# Download the latest install.sh from the master branch
ADD https://raw.githubusercontent.com/SinusBot/docker/master/install.sh .
RUN chmod +x install.sh

# Download/Install SinusBot
RUN bash install.sh sinusbot

# Download/Install youtube-dl
RUN bash install.sh youtube-dl

ADD https://raw.githubusercontent.com/SinusBot/docker/master/entrypoint.sh .
RUN chmod +x entrypoint.sh

EXPOSE 8087

VOLUME ["/opt/sinusbot/data", "/opt/sinusbot/scripts"]

ENTRYPOINT ["/opt/sinusbot/entrypoint.sh"]

HEALTHCHECK --interval=1m --timeout=5s \
  CMD curl -f http://localhost:8087/api/v1/botId || exit 1