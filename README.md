# Automated Bandcamp Downloader

This is a containerised version of [Ezwen's Bandcamp Collection Downloader](https://framagit.org/Ezwen/bandcamp-collection-downloader).
I wanted to run it on my docker-capable NAS, so wrapped it in a docker image based on the
[linuxserver.io](https://www.linuxserver.io/) images.

## How To Run

1. Pull it from [Docker Hub](https://hub.docker.com/repository/docker/chooban/bandcamp-downloader).
   There are images for `arm64` and `amd64`.

```
docker pull chooban/bandcamp-downloader
```

2. Retrieve your cookies using the options specified in the parent project. Then put them in the folder
   you're going to specify as the config volume (see below).

3. Run it

```
docker run \
  -e PUID=<user id for output files>
  -e PGID=<group id for output files>
  -e BANDCAMP_USERNAME=<USERNAME GOES HERE> \
  -v ./config/:/bandcamp-config \
  -v ./downloads/:/download \
  chooban/bandcamp-downloader
```
