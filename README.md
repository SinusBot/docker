# SinusBot Docker image

[![Docker Pulls](https://img.shields.io/docker/pulls/sinusbot/docker.svg)](https://hub.docker.com/r/sinusbot/docker/)
[![Docker Automated build](https://img.shields.io/docker/automated/sinusbot/docker.svg)](https://hub.docker.com/r/sinusbot/docker/)

## Installation

### docker-compose

For that you can use the docker-compose file which is located [here](docker-compose.yml).

### docker

```
docker run -d -p 8087:8087 -v scripts:/opt/sinusbot/scripts -v data:/opt/sinusbot/data --name sinusbot sinusbot/docker
```

## Get Sinusbot Password

After the SinusBot docker image will be started with the `docker run` command an ID will be returned in the next line.
Use in the console the command `docker logs <ID>` and replace `<ID>` with the long Identifier for the docker container. This will print out the logs of the container.
There should be an output on the top like this which contains your credentials:
```
[...]
-------------------------------------------------------------------------------
Generating new bot instance with account 'admin' and password 'YOUR_PASSWORD_HERE'
PLEASE MAKE SURE TO CHANGE THE PASSWORD DIRECTLY AFTER YOUR FIRST LOGIN!!!
-------------------------------------------------------------------------------
[...]
```
There is it, your username and your generated random password.

## Updating the image

Run the following command to update the image to the latest version:

```
docker pull sinusbot/docker
```

After that you just need to restart your container, by executing the following command:

```
docker restart CONTAINER_NAME
```
