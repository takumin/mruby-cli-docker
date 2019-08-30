FROM debian:stable AS osxcross

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      build-essential \
      ca-certificates \
      clang \
      cmake \
      git \
      libgmp-dev \
      libmpc-dev \
      libmpfr-dev \
      libssl-dev \
      libxml2-dev \
      wget \
      zlib1g-dev \
 && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/tpoechtrager/osxcross.git /opt/osxcross

WORKDIR /opt/osxcross/tarballs
RUN wget https://s3.dockerproject.org/darwin/v2/MacOSX10.10.sdk.tar.xz

WORKDIR /opt/osxcross
RUN UNATTENDED=yes OSX_VERSION_MIN=10.7 ./build.sh

FROM debian:stable

COPY --from=osxcross /opt/osxcross/target /opt/osxcross
ENV PATH /opt/osxcross/bin:$PATH

RUN dpkg --add-architecture arm64 \
 && dpkg --add-architecture armhf \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
      automake \
      bison \
      build-essential \
      bzip2 \
      ca-certificates \
      clang \
      cpio \
      crossbuild-essential-arm64 \
      crossbuild-essential-armhf \
      curl \
      debhelper \
      file \
      gem \
      genisoimage \
      git \
      gobject-introspection \
      gzip \
      intltool \
      libgcab-dev \
      libgirepository1.0-dev \
      libgsf-1-dev \
      libssl-dev \
      libtool \
      libxml2-dev \
      llvm-dev \
      make \
      mingw-w64 \
      msitools \
      patch \
      rake \
      rpm \
      ruby-dev \
      sed \
      uuid-dev \
      valac \
      wget \
      xz-utils \
 && rm -rf /var/lib/apt/lists/* \
 && gem install fpm --no-document

ONBUILD WORKDIR /home/mruby/code
ONBUILD ENV GEM_HOME /home/mruby/.gem/

ONBUILD ENV PATH $GEM_HOME/bin/:$PATH
ONBUILD ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/
