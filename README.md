# SinusBot Discord only Docker image

[![Docker Automated build](https://img.shields.io/docker/automated/sinusbot/docker.svg)](https://store.docker.com/community/images/sinusbot/docker)
[![Docker Build Status](https://img.shields.io/docker/build/sinusbot/docker.svg)](https://store.docker.com/community/images/sinusbot/docker/builds)
[![Docker Pulls](https://img.shields.io/docker/pulls/sinusbot/docker.svg)](https://store.docker.com/community/images/sinusbot/docker)
[![Image Info](https://images.microbadger.com/badges/image/sinusbot/docker.svg)](https://microbadger.com/images/sinusbot/docker)

## Installation

### docker-compose

Download the [docker-compose file](docker-compose.yml) in it's own directory and start it with `docker-compose up`.

### docker

```bash
docker run -d -p 8087:8087 -v scripts:/opt/sinusbot/scripts -v data:/opt/sinusbot/data --name sinusbot sinusbot/docker:discord
```

## For more information checkout the [README in the master branch](https://github.com/SinusBot/docker/blob/master/README.md).
