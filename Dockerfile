FROM debian:stretch-slim

RUN apt-get update && apt-get install -y bzip2 wget less x11vnc xvfb libxcursor1 libnss3 libegl1-mesa libasound2 libglib2.0-0 python

WORKDIR /opt/ts3soundboard

ADD install.sh .

# Installing SinusBot
RUN wget -qO - https://www.sinusbot.com/pre/sinusbot-0.13.37-f7e9ece.tar.bz2 | tar xj && \
    cp config.ini.dist config.ini && \
    chmod +x /opt/ts3soundboard/sinusbot && \
    chmod +x install.sh

# Installing Teamspeak
RUN bash install.sh teamspeak

# Installing youtube-dl
RUN bash install.sh youtube-dl

EXPOSE 8087

VOLUME ["/opt/ts3soundboard/data", "/opt/ts3soundboard/scripts"]

ENTRYPOINT ["/opt/ts3soundboard/sinusbot"]
