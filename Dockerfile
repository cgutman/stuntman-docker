FROM ubuntu:latest

EXPOSE 3478/tcp 3478/udp

RUN set -ex && \
    apt-get update && \
    apt-get install -y libboost-dev && \
    apt-get install -y libssl-dev && \
    apt-get install -y g++ && \
    apt-get install -y make && \
    apt-get install -y coreutils && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

COPY stunserver /opt/

WORKDIR /opt

RUN make

USER nobody

ENTRYPOINT ["/usr/bin/stdbuf", "-oL", "/opt/stunserver"]
