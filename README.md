# SinusBot Docker image

[![Docker Pulls](https://img.shields.io/docker/pulls/sinusbot/docker.svg)](https://hub.docker.com/r/sinusbot/docker)

## Features

- Easily updatable (see [instructions](#Updating) below)
- Minimal dependencies to the Host system
- Integrated Text-to-Speech engine
- Compatible with macOS

## Addtional Features
- Option to switch to yt-dlp

## Disclaimer

By using this image you accept the [Privacy statement of the TeamSpeak Systems GmbH](https://www.teamspeak.com/en/privacy-and-terms), the [SinusBot Privacy Policy](https://forum.sinusbot.com/help/privacy-policy/) and SinusBot license agreement.

> © 2013-2021 Michael Friese. All rights reserved. (https://www.sinusbot.com)
>
> This software is free for personal use only. If you want to use it commercially, please contact the author.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
>
> You may NOT redistribute this software or use this software commercially without prior written permission from the author.

*TeamSpeak 3 is © TeamSpeak Systems GmbH. This product and the author is in no way affiliated with TeamSpeak Systems GmbH.*

*Discord is © Hammer & Chisel Inc. This product and the author is in no way affiliated with Hammer & Chisel Inc.*

## Usage

### docker

#### root (not recommended)

```bash
docker run -d -p 8087:8087 \
           -v /opt/sinusbot/scripts:/opt/sinusbot/scripts \
           -v /opt/sinusbot/data:/opt/sinusbot/data \
           --name sinusbot \
           sinusbot/docker
```

#### unprivileged user

It is recommended that you run the SinusBot as a non-root user, even though the docker container is mostly isolated from the host.
This can be done as described in the following:

- add a new user:
  
  `useradd --no-create-home -s /sbin/nologin -U sinusbot`
- create the required folders if they don't exist:

  `mkdir -p /opt/sinusbot/data /opt/sinusbot/scripts`
- give the user permissions to the folders:

  `chown -R sinusbot:sinusbot /opt/sinusbot`
- Run the docker image with the `UID` and `GID` environment variables set to the correct user- and group-ID as shown below:

  ```bash
  docker run -d -p 8087:8087 \
             -v /opt/sinusbot/scripts:/opt/sinusbot/scripts \
             -v /opt/sinusbot/data:/opt/sinusbot/data \
             -e UID=$(id -u sinusbot) \
             -e GID=$(id -g sinusbot) \
             --name sinusbot \
             sinusbot/docker
  ```

### docker-compose

Download the [docker-compose file](docker-compose.yml) in it's own directory and start it with `docker-compose up`.

To run via docker-compose as a non-root user, follow the docker instruction above to create a `sinusbot` user. Then append the following to your `docker-compose.yml`:

```yaml
  environment:
    UID: # insert output of `id -u sinusbot`
    GID: # insert output of `id -g sinusbot`
```

## Tags

- `latest` is the default tag
- `discord` is a discord-only version of `latest` and does not contain the TeamSpeak client with additional dependencies
- every release is tagged with it's version (for example: `1.0.0-beta.6-f290553`) and a discord-only tag (for example: `1.0.0-beta.6-f290553-discord`)

You view the [full list of tags](https://hub.docker.com/r/sinusbot/docker/tags) for specific versions.

## Get Password

After starting the SinusBot docker image with `docker run` an ID will be returned in the next line.
Use the command `docker logs sinusbot` to print out the logs of the container.
The beginning of the log should contain your credentials:

```txt
[...]
-------------------------------------------------------------------------------
Generating new bot instance with account 'admin' and password 'YOUR_PASSWORD_HERE'
PLEASE MAKE SURE TO CHANGE THE PASSWORD DIRECTLY AFTER YOUR FIRST LOGIN!!!
-------------------------------------------------------------------------------
[...]
```

## Override Password

By setting the `OVERRIDE_PASSWORD` environment variable you can override the password of the SinusBot. Example:

```bash
docker run -d -p 8087:8087 \
           -v /opt/sinusbot/scripts:/opt/sinusbot/scripts \
           -v /opt/sinusbot/data:/opt/sinusbot/data \
           -e OVERRIDE_PASSWORD=foobar \
           --name sinusbot sinusbot/docker
```

## License

To use your [license](https://sinusbot.github.io/docs/licenses/), which you've got from the [License Page in the Forum](https://forum.sinusbot.com/license), you need to save the `private.dat` into the data folder.

After restarting the container (`docker restart sinusbot`) your licensed instances should appear automatically.

## Updating

Docker containers themselves should not store application data, instead the data is stored in volumes (in this case `scripts` and `data`).
To upgrade a container you need to remove and re-run it as shown below.

1. Stop and remove the old container.

    ```bash
    docker stop sinusbot && docker rm sinusbot
    ```

2. Pull the latest image:

    ```bash
    docker pull sinusbot/docker
    ```

3. Create a new container with your volumes as described in the [usage](#usage) section above.

*It is also possible to automate this process by running [Watchtower](https://containrrr.github.io/watchtower/).*

## Text-to-Speech

The Chromium Text-to-Speech engine is pre-installed but disabled by default due to higher cpu/memory usage.

To enable it you simply need to set the `TTS.Enabled` property to `true` in the `config.ini` stored in the `data` volume (`/opt/sinusbot/data`) and restart your container (`docker restart sinusbot`).
Once it's enabled it can be used by setting the locale to `en-US` or `de-DE` in the instance settings.

## Discord only image

There is an image for discord only usage, this won't contain the TeamSpeak client with the additional dependencies.
To use it you just have to use the `discord` tag instead of `latest` (default) tag:

```bash
docker run -d -p 8087:8087 \
           -v /opt/sinusbot/scripts:/opt/sinusbot/scripts \
           -v /opt/sinusbot/data:/opt/sinusbot/data \
           --name sinusbot sinusbot/docker:discord
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
      - /opt/sinusbot/scripts:/opt/sinusbot/scripts
      - /opt/sinusbot/data:/opt/sinusbot/data
    networks:
     - mynetwork
networks:
    mynetwork:
        driver: bridge
```

## Development

### Deploy Version

To build and release a new version, clone this repository and run:

```bash
docker login
./release_as_latest.sh <VERSION>
```

Replace `<VERSION>` with the version, e.g. `1.0.0-beta.10-202ee4d`.

This will build and upload the following tags: `<VERSION>-discord`, `<VERSION>`, `discord`, `latest`

`./release_version.sh` does the same but without setting `discord`, `latest`.
