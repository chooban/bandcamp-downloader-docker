FROM ghcr.io/linuxserver/baseimage-ubuntu:bionic

ARG BUILD_DATE
ARG VERSION
ARG BANDCAMP_DOWNLOADER_RELEASE

ENV PYTHONIOENCODING=utf-8

RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
  gnupg && \
  apt-get install -y --no-install-recommends \
  curl \
  jq \
  python3 \
  python3-pip \
  unzip && \
  apt-get install --no-install-recommends -y \
  openjdk-11-jre-headless && \
  pip3 install -U --no-cache-dir pip && \
  pip install -U --no-cache-dir --find-links https://wheel-index.linuxserver.io/ubuntu/ \
  pyppeteer && \
  echo "**** install bandcamp-downloader ****" && \
  if [ -z ${BANDCAMP_DOWNLOADER_RELEASE+x} ]; then \
  BANDCAMP_DOWNLOADER_RELEASE=$(curl -sX GET "https://framagit.org/api/v4/projects/Ezwen%2fbandcamp-collection-downloader/releases" \
  | jq -r .[0].tag_name); \
  fi && \
  DOWNLOADER_VER=${BANDCAMP_DOWNLOADER_RELEASE#v} && \
  DOWNLOAD_URL=$(curl -sX GET "https://framagit.org/api/v4/projects/Ezwen%2fbandcamp-collection-downloader/releases" \
  | jq -r .[0].assets.links[0].url) && \
  echo "**** downloading ${DOWNLOADER_VER} ****" && \
  mkdir -p /app/bandcamp-downloader/ && \
  curl -o \
  /app/bandcamp-downloader/bandcamp-downloader.jar -L \
  "${DOWNLOAD_URL}" && \
  apt-get clean autoclean && \
  apt-get autoremove --yes && \
  rm -rf /var/lib/apt/lists/*

VOLUME /bandcamp-config
VOLUME /download

ENV BANDCAMP_USERNAME=noname
ENV FORMAT=flac

CMD java -jar /app/bandcamp-downloader/bandcamp-downloader.jar \
  --cookies-file=/bandcamp-config/cookies.txt \
  --download-folder=/download \
  --audio-format=$FORMAT \
  $BANDCAMP_USERNAME

