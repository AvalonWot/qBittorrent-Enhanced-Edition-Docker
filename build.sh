#!/bin/bash

docker build \
    --build-arg HTTP_PROXY=http://192.168.12.2:10808 \
    --build-arg HTTPS_PROXY=http://192.168.12.2:10808 \
    --build-arg NO_PROXY=localhost,127.0.0.1 \
    --tag avalonwot/qbittorrentee:latest \
    --force-rm \
    .
