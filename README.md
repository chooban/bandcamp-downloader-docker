# Automated Bandcamp Downloader

This is a containerised version of [Ezwen's Bandcamp Collection Downloader](https://framagit.org/Ezwen/bandcamp-collection-downloader).
I wanted to run it on my docker-capable NAS, so wrapped it in a docker image based on the
[linuxserver.io](https://www.linuxserver.io/) images.

## How To Run

1. Build the image, or pull it from [Docker Hub](https://hub.docker.com/repository/docker/chooban/bandcamp-downloader).

```
docker build . -t bandcamp
```

2. Retrieve your cookies using the options specified in the parent project. Then put them in the folder
   you're going to specify as the config volume (see below).

3. Run it

```
docker run \
  -e PUID=<user id for output files>
  -e PGID=<group id for output files>
  -e BANDCAMP_USERNAME=<USERNAME GOES HERE> \
  -v /Users/ross/Projects/bandcamp-downloader/config/:/bandcamp-config \
  -v /Users/ross/Projects/bandcamp-downloader/download/:/download \
  bandcamp
```
