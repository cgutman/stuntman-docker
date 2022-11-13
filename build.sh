#!/bin/sh

set -e

# AMD64
docker build --pull -t cgutman/stuntman-server:manifest-amd64 --build-arg ARCH=amd64/ .
docker push cgutman/stuntman-server:manifest-amd64

# ARM64
docker build --pull -t cgutman/stuntman-server:manifest-arm64v8 --build-arg ARCH=arm64v8/ .
docker push cgutman/stuntman-server:manifest-arm64v8

# Create combined multi-arch manifest
docker manifest create cgutman/stuntman-server:latest \
	--amend cgutman/stuntman-server:manifest-amd64 \
	--amend cgutman/stuntman-server:manifest-arm64v8
docker manifest push cgutman/stuntman-server:latest
