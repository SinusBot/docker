# SinusBot Docker image

[![Docker Automated build](https://img.shields.io/docker/automated/sinusbot/docker.svg)](https://hub.docker.com/r/sinusbot/docker)
[![Docker Build Status](https://img.shields.io/docker/build/sinusbot/docker.svg)](https://hub.docker.com/r/sinusbot/docker/builds)
[![Docker Pulls](https://img.shields.io/docker/pulls/sinusbot/docker.svg)](https://hub.docker.com/r/sinusbot/docker)
[![Image Info](https://images.microbadger.com/badges/image/sinusbot/docker.svg)](https://microbadger.com/images/sinusbot/docker)

## Installation

By using this image you accept the [Privacy statement of the TeamSpeak Systems GmbH](https://www.teamspeak.com/en/privacy-and-terms) and the license agreement of the SinusBot.

### docker-compose

Download the [docker-compose file](https://github.com/SinusBot/docker/blob/master/docker-compose.yml) in it's own directory and start it with `docker-compose up`.

### docker

```bash
docker run -d -p 8087:8087 \
           -v scripts:/opt/sinusbot/scripts \
           -v data:/opt/sinusbot/data \
           --name sinusbot sinusbot/docker
```

## Get Password

After starting the SinusBot docker image with `docker run` an ID will be returned in the next line.
Use the command `docker logs <ID>` (replace `<ID>` with the long container ID) to print out the logs of the container.
The beginning of the log should contain your credentials:

```txt
[...]
-------------------------------------------------------------------------------
Generating new bot instance with account 'admin' and password 'YOUR_PASSWORD_HERE'
PLEASE MAKE SURE TO CHANGE THE PASSWORD DIRECTLY AFTER YOUR FIRST LOGIN!!!
-------------------------------------------------------------------------------
[...]
```

## Password overriding

By setting the `OVERRIDE_PASSWORD` environment variable you can override the password of the SinusBot. Usage:

```bash
docker run -d -p 8087:8087 \
           -v scripts:/opt/sinusbot/scripts \
           -v data:/opt/sinusbot/data \
           -e OVERRIDE_PASSWORD=foobar \
           --name sinusbot sinusbot/docker
```

## License

To use your license, which you've got from the [forums](https://forum.sinusbot.com/license) just drop the `private.dat` into the data folder.
After that you can restart the SinusBot and the license should be applied.

## Discord only image

There is an image for discord only usage, this won't contain the TeamSpeak client with the additonal dependencies.
To use it you just have to use the `discord` tag instead of `latest` (default) tag:

```bash
docker run -d -p 8087:8087 \
           -v scripts:/opt/sinusbot/scripts \
           -v data:/opt/sinusbot/data \
           --name sinusbot sinusbot/docker:discord
```

## Updating the image

Run the following command to update the image to the latest version:

```bash
docker pull sinusbot/docker
```

After that you just need to restart your container, by executing the following command:

```bash
docker restart CONTAINER_NAME
```

## Text-to-Speech

Per default, there is the Chromium Text-to-Speech engine pre installed. It can be simply enabled by setting the `TTS.Enabled` property in the `config.ini` of the `data` volume to `true`. It's per default disabled due performance issues / memory costs.

Once it's enabled it can be used by setting in the Instance settings `en-US` or `de-DE` as locale.

## Other Docker registries

### QUAY

[![Docker Repository on Quay](https://quay.io/repository/sinusbot/docker/status "Docker Repository on Quay")](https://quay.io/repository/sinusbot/docker)

Can be pulled by using:

```bash
docker pull quay.io/sinusbot/docker
```

Also the discord image is available on the `discord` tag:

```bash
docker pull quay.io/sinusbot/docker:discord
```

For using docker-compose with [quay.io](https://quay.io) just replace `sinusbot/docker` with `quay.io/sinusbot/docker`. Example:

```yaml
# docker-compose.yml
sinusbot:
  image: quay.io/sinusbot/docker
  restart: always
  ports:
    - 8087:8087
  volumes:
    - ./scripts:/opt/sinusbot/scripts
    - ./data:/opt/sinusbot/data
```

## docker-compose with TeamSpeak 3 Server

In the SinusBot you have to use the network alias `teamspeak.docker.local` as hostname. 

```yaml
# docker-compose.yml
version: '2'
services:
  teamspeak:
    image: teamspeak
    restart: always
    ports:
      - 9987:9987/udp
      - 10011:10011
      - 30033:30033
    environment:
      TS3SERVER_LICENSE: accept
    networks:
      mynetwork:
        aliases:
          - teamspeak.docker.local

  sinusbot:
    image: sinusbot/docker
    restart: always
    ports:
      - 8087:8087
    volumes:
      - ./scripts:/opt/sinusbot/scripts
      - ./data:/opt/sinusbot/data
    networks:
     - mynetwork
networks:
    mynetwork:
        driver: bridge
```
