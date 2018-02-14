# SinusBot Docker image

[![Docker Pulls](https://img.shields.io/docker/pulls/sinusbot/docker.svg)](https://hub.docker.com/r/sinusbot/docker/)
[![Docker Automated build](https://img.shields.io/docker/automated/sinusbot/docker.svg)](https://hub.docker.com/r/sinusbot/docker/)

## Installation

### docker-compose

For that you can use the docker-compose file which is located [here](docker-compose.yml).

### docker

```
docker run -d -p 8087:8087 -v scripts:/opt/ts3soundboard/scripts -v data:/opt/ts3soundboard/data sinusbot/docker
```

