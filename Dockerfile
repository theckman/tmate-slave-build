FROM alpine:edge

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add --no-cache build-base \
                       ca-certificates \
                       bash \
                       wget \
                       git \
                       openssh \
                       libc6-compat \
                       automake \
                       autoconf \
                       zlib-dev \
                       libevent-dev \
                       msgpack-c-dev \
                       ncurses-dev \
                       libexecinfo-dev \
                       libssh-dev && \
    mkdir /src

COPY build_tmate-slave.sh /

CMD ["/bin/bash", "-c", "/build_tmate-slave.sh"]
