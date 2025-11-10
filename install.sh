#!/bin/sh

INFO="[INFO]"
ERROR="[ERROR]"

# 检查 CPU 架构
ARCH_CHECK=$(uname -m)

echo "$INFO Check CPU architecture ..."

# 使用 POSIX 兼容的 case 结构进行检查
case "$ARCH_CHECK" in
    "x86_64")
        ARCH_FILE="qbittorrent-enhanced-nox_x86_64-linux-musl_static.zip"
        ;;
    "armv7l")
        ARCH_FILE="qbittorrent-enhanced-nox_arm-linux-musleabi_static.zip"
        ;;
    "aarch64")
        ARCH_FILE="qbittorrent-enhanced-nox_aarch64-linux-musl_static.zip"
        ;;
    *)
        echo "$ERROR This architecture is not supported."
        exit 1
        ;;
esac

# 下载文件
echo "Downloading binary file: $ARCH_FILE"

# 确保 ./ReleaseTag 文件存在，否则 cat 可能会失败
if [ -f ./ReleaseTag ]; then
    TAG=$(cat ./ReleaseTag)
    echo "qbittorrent version: $TAG"
else
    echo "$ERROR ./ReleaseTag file not found."
    exit 1
fi

# 在 sh 中，PWD 通常是定义好的，但为了兼容性，也可以使用 $(pwd)
DOWNLOAD_PATH=$(pwd)

# 确保 curl 和 unzip 已经安装在 Alpine 镜像中 (apk add curl unzip)
curl -L -o "$DOWNLOAD_PATH/qbittorrentee.zip" "https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases/download/release-$TAG/$ARCH_FILE"

echo "Download binary file: $ARCH_FILE completed"

unzip qbittorrentee.zip