FROM debian:stretch-slim

LABEL maintainer="Max Schmitt <max@schmitt.mx>"
LABEL description="SinusBot Docker Image for Discord only."

# install dependencies and clean up afterwards
RUN apt update && \
    apt install -y --no-install-recommends ca-certificates bzip2 curl python && \
    apt -q clean all && \
    rm -rf /tmp/* /var/tmp/*

WORKDIR /opt/sinusbot

# Install SinusBot
RUN echo "Downloading SinusBot..." \
	&& curl -s https://www.sinusbot.com/pre/sinusbot-0.14.3-0e747fd.tar.bz2 | tar xj \
	&& chmod 755 sinusbot \
	&& cp config.ini.dist config.ini \
	&& sed -i "s|^TS3Path.*|TS3Path = \"\"|g" config.ini \
	&& mv scripts default_scripts && \
	&& ln -s data/private.dat private.dat \
	&& echo "Successfully installed SinusBot"

# Install youtube-dl
RUN echo "Downloading youtube-dl..." \
	&& curl -s -o /usr/local/bin/youtube-dl https://yt-dl.org/downloads/latest/youtube-dl \
	&& chmod 755 /usr/local/bin/youtube-dl \
	&& echo 'YoutubeDLPath = "/usr/local/bin/youtube-dl"' >> config.ini \
	&& echo "Successfully installed youtube-dl"

ADD entrypoint.sh .
RUN chmod 755 entrypoint.sh

EXPOSE 8087

VOLUME ["/opt/sinusbot/data", "/opt/sinusbot/scripts"]

ENTRYPOINT ["/opt/sinusbot/entrypoint.sh"]

HEALTHCHECK --interval=1m --timeout=5s \
  CMD curl -f http://localhost:8087/api/v1/botId || exit 1