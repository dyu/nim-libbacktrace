#!/bin/sh

set -e

UNAME=`uname`
ARCH=`arch`
TARGET_ARCH='x86_64'
case "$UNAME" in
    Darwin)
    [ "$ARCH" = 'arm64' ] && TARGET_ARCH='aarch64'
    ZCC_OPTS="-target $TARGET_ARCH-macos.11-none" make CC=$PWD/clang -j4
    ;;
    *)
    make CC=$PWD/clang -j4
    ;;
esac

[ "$1" = "install" ] && nimble install -y