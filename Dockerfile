FROM alpine:latest AS build-env
RUN apk add --no-cache make g++ musl-dev boost-dev openssl-dev
COPY stunserver /opt/
WORKDIR /opt
RUN make

FROM alpine:latest
COPY --from=build-env /opt/stunserver /opt
RUN apk add --no-cache libstdc++ coreutils
USER nobody

EXPOSE 3478/tcp 3478/udp

ENTRYPOINT ["/usr/bin/stdbuf", "-oL", "/opt/stunserver"]
