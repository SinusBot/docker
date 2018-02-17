# SinusBot Docker image

[![Docker Automated build](https://img.shields.io/docker/automated/sinusbot/docker.svg)](https://store.docker.com/community/images/sinusbot/docker)
[![Docker Build Status](https://img.shields.io/docker/build/sinusbot/docker.svg)](https://store.docker.com/community/images/sinusbot/docker/builds)
[![Docker Pulls](https://img.shields.io/docker/pulls/sinusbot/docker.svg)](https://store.docker.com/community/images/sinusbot/docker)
[![Image Info](https://images.microbadger.com/badges/image/sinusbot/docker.svg)](https://microbadger.com/images/sinusbot/docker)

## Installation

By using this image you accept the end user license agreement of TeamSpeak 3 and the license agreement of the SinusBot.

### docker-compose

Download the [docker-compose file](https://github.com/SinusBot/docker/blob/master/docker-compose.yml) in it's own directory and start it with `docker-compose up`.

### docker

```bash
docker run -d -p 8087:8087 \
           -v scripts:/opt/sinusbot/scripts \
           -v data:/opt/sinusbot/data \
           --name sinusbot sinusbot/docker
```

## Get Sinusbot Password

After starting the SinusBot docker image with `docker run` an ID will be returned in the next line.
Use the command `docker logs <ID>` (replace `<ID>` with the long container ID) to print out the logs of the container.
The beginning of the log should contain your credentials:

```
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

## Discord only image

There exists an image for discord only usage, this won't contain the teamspeak client with the additonal dependencies. For that use the `discord` tag instead of the `latest` (default) tag:

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
sinusbot:
  image: quay.io/sinusbot/docker
  restart: always
  ports:
    - 8087:8087
  volumes:
    - ./scripts:/opt/sinusbot/scripts
    - ./data:/opt/sinusbot/data
```
