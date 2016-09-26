FROM debian:sid

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential \
                       git \
                       pkg-config \
                       automake \
                       autoconf \
                       cmake \
                       zlib1g-dev \
                       libevent-dev \
                       libmsgpack-dev \
                       libncurses-dev \
                       libssh-dev && \
    apt-get clean -y

RUN mkdir /build /src

COPY build_tmate-slave.sh /

CMD ["/bin/bash", "-c", "/build_tmate-slave.sh"]
