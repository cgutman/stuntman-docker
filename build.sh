#!/bin/sh

set -e

# AMD64
docker buildx build --platform linux/amd64 --pull -t cgutman/stuntman-server:manifest-amd64 .
docker push cgutman/stuntman-server:manifest-amd64

# ARM64
docker buildx build --platform linux/arm64 --pull -t cgutman/stuntman-server:manifest-arm64v8 .
docker push cgutman/stuntman-server:manifest-arm64v8

# Create combined multi-arch manifest
docker manifest create cgutman/stuntman-server:latest \
	--amend cgutman/stuntman-server:manifest-amd64 \
	--amend cgutman/stuntman-server:manifest-arm64v8
docker manifest push cgutman/stuntman-server:latest
