# SinusBot Docker image

[![Docker Automated build](https://img.shields.io/docker/automated/sinusbot/docker.svg)](https://hub.docker.com/r/sinusbot/docker/)
[![Docker Build Status](https://img.shields.io/docker/build/sinusbot/docker.svg)](https://hub.docker.com/r/sinusbot/docker/builds/)
[![Docker Pulls](https://img.shields.io/docker/pulls/sinusbot/docker.svg)](https://hub.docker.com/r/sinusbot/docker/)
[![Image Info](https://images.microbadger.com/badges/image/sinusbot/docker.svg)](https://microbadger.com/images/sinusbot/docker)

## Installation

### docker-compose

Download the [docker-compose file](docker-compose.yml) in it's own directory and start it with `docker-compose up`.

### docker

```bash
docker run -d -p 8087:8087 -v scripts:/opt/sinusbot/scripts -v data:/opt/sinusbot/data --name sinusbot sinusbot/docker
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

## Updating the image

Run the following command to update the image to the latest version:

```bash
docker pull sinusbot/docker
```

After that you just need to restart your container, by executing the following command:

```bash
docker restart CONTAINER_NAME
```
