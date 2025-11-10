FROM alpine:3.22.2 AS builder

LABEL maintainer="AvalonWot"

WORKDIR /qbittorrent

COPY install.sh /qbittorrent/
COPY ReleaseTag /qbittorrent/

RUN apk add --no-cache ca-certificates curl

RUN chmod a+x install.sh \
    && sh install.sh

FROM gcr.io/distroless/python3-debian12:nonroot

# environment settings
ENV TZ=Asia/Shanghai

USER nonroot

WORKDIR /home/nonroot

# add local files and install qbitorrent
COPY --from=builder --chown=nonroot:nonroot /qbittorrent/qbittorrent-nox /home/nonroot/qbittorrent-nox

# ports and volumes
VOLUME /downloads /config
EXPOSE 8080 6888 6888/udp
ENTRYPOINT ["/home/nonroot/qbittorrent-nox"]
CMD ["--webui-port=8080" "--profile=/config", "--confirm-legal-notice"]