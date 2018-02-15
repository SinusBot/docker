# SinusBot Discord only Docker image

[![Docker Automated build](https://img.shields.io/docker/automated/sinusbot/docker.svg)](https://hub.docker.com/r/sinusbot/docker/)
[![Docker Build Status](https://img.shields.io/docker/build/sinusbot/docker.svg)](https://hub.docker.com/r/sinusbot/docker/builds/)
[![Docker Pulls](https://img.shields.io/docker/pulls/sinusbot/docker.svg)](https://hub.docker.com/r/sinusbot/docker/)
[![](https://images.microbadger.com/badges/image/sinusbot/docker.svg)](https://microbadger.com/images/sinusbot/docker "Get your own image badge on microbadger.com")

## Installation

### docker-compose

For that you can use the docker-compose file which is located [here](docker-compose.yml).

### docker

```
docker run -d -p 8087:8087 -v scripts:/opt/sinusbot/scripts -v data:/opt/sinusbot/data --name sinusbot sinusbot/docker:discord
```

## For more information checkout the README.md in the master branch [here](https://github.com/SinusBot/docker/blob/master/README.md).