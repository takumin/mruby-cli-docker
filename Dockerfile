FROM debian:stable AS osxcross

RUN apt-get -yqq update \
 && apt-get -yqq install --no-install-recommends \
      autoconf \
      automake \
      build-essential \
      ca-certificates \
      clang \
      cmake \
      git \
      libgmp-dev \
      libmpc-dev \
      libmpfr-dev \
      libssl-dev \
      libtool \
      libxml2-dev \
      llvm-dev \
      lzma-dev \
      pkg-config \
      uuid-dev \
      wget \
      zlib1g-dev \
 && apt-get -yqq clean \
 && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/tpoechtrager/osxcross.git /opt/osxcross

WORKDIR /opt/osxcross/tarballs
# Origin: https://github.com/docker/golang-cross/blob/master/osx-cross.sh
RUN wget -q https://s3.dockerproject.org/darwin/v2/MacOSX10.10.sdk.tar.xz

WORKDIR /opt/osxcross
RUN UNATTENDED=yes OSX_VERSION_MIN=10.8 ./build.sh

FROM debian:stable

LABEL maintainer "Takumi Takahashi <takumiiinn@gmail.com>"

COPY --from=osxcross /opt/osxcross/target /opt/osxcross
ENV PATH /opt/osxcross/bin:$PATH

RUN dpkg --add-architecture amd64 \
 && dpkg --add-architecture arm64 \
 && dpkg --add-architecture armhf \
 && dpkg --add-architecture i386 \
 && apt-get -yqq update \
 && apt-get -yqq install --no-install-recommends \
      autoconf \
      automake \
      bison \
      build-essential \
      ca-certificates \
      clang \
      crossbuild-essential-amd64 \
      crossbuild-essential-arm64 \
      crossbuild-essential-armhf \
      crossbuild-essential-i386 \
      curl \
      flex \
      gem \
      git \
      libssl1.1 \
      libtool \
      libuuid1 \
      libxml2 \
      llvm-7-dev \
      mingw-w64 \
      pkg-config \
      rake \
      ruby \
      wget \
      zlib1g \
 && apt-get -yqq clean \
 && rm -rf /var/lib/apt/lists/*
