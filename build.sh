#!/bin/sh

set -e

UNAME=`uname`
ARCH=`arch`
TARGET_ARCH='x86_64'
case "$UNAME" in
    Darwin)
    #[ "$ARCH" = 'arm64' ] && TARGET_ARCH='aarch64'
    #ZCC_OPTS="-target $TARGET_ARCH-macos.11-none" make CC=$PWD/clang CXX=$PWD/clang++ -j4
    make CC=clang CXX=clang++ -j4
    ;;
    *)
    make CC=gcc CXX=g++ -j4
    ;;
esac

[ "$1" = "install" ] && nimble install -y

