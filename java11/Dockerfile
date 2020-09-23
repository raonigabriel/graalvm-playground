FROM debian:stretch-slim as builder

ARG DEBIAN_FRONTEND=noninteractive
ARG MUSL_DIR=/usr/local/musl

RUN apt-get update && \
    apt-get -y --no-install-recommends install make automake build-essential wget

RUN mkdir -p $MUSL_DIR && \
    wget -q --no-check-certificate https://musl.libc.org/releases/musl-1.2.1.tar.gz && \
    tar zxf musl-1.2.1.tar.gz && \
    cd musl-1.2.1 && \
    ./configure --disable-shared --prefix=${MUSL_DIR} && \
    make && \
    make install

ENV PATH $PATH:$MUSL_DIR/bin
ENV CC musl-gcc

RUN wget -q --no-check-certificate https://zlib.net/zlib-1.2.11.tar.gz && \
    tar zxf zlib-1.2.11.tar.gz && \
    cd zlib-1.2.11 && \
    ./configure --static --prefix=${MUSL_DIR} && \
    make && \
    make install && \
    cp /usr/lib/gcc/x86_64-linux-gnu/6/libstdc++.a $MUSL_DIR/lib/libstdc++.a

FROM debian:stretch-slim

# Update and install dependencies and download and install Maven
ARG DEBIAN_FRONTEND=noninteractive
ARG MAVEN_VERSION=3.6.3
ARG MAVEN_PKG=https://downloads.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz
ENV MAVEN_HOME=/opt/apache-maven-$MAVEN_VERSION
RUN apt-get update && \
    apt-get -y --no-install-recommends install ca-certificates gcc libc6-dev zlib1g-dev curl git nano upx-ucl && \
    rm -rf /var/lib/apt/lists/* && \
    curl -s -L $MAVEN_PKG | tar -xz -C /opt

# Download and install GraalVM (also adds native-image and wasm)]
ARG GRAALVM_VERSION=20.2.0
ARG GRAALVM_PKG=https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-$GRAALVM_VERSION/graalvm-ce-java11-linux-amd64-$GRAALVM_VERSION.tar.gz
ENV JAVA_HOME=/opt/graalvm-ce-java11-$GRAALVM_VERSION
ENV PATH=$MAVEN_HOME/bin:$JAVA_HOME/jre/bin:$JAVA_HOME/bin:/usr/local/musl/bin:$PATH
RUN curl -s -L $GRAALVM_PKG | tar -xz -C /opt && \
    gu install native-image wasm

# Metadata
LABEL org.label-schema.schema-version = "1.0" \
      org.label-schema.name="graalvm-playground-$JAVA_VERSION" \
      org.label-schema.description="A docker image with GraalVM, OpenJDK, Node, Maven and Git" \
      org.label-schema.vcs-url="https://github.com/raonigabriel/graalvm-playground" \
      org.label-schema.version="$GRAALVM_VERSION-java11"

# Copy muslc stuff from previous stage
COPY --from=builder /usr/local/musl /usr/local/musl

# Create default group and user (make more jenkins-docker friendly) 
RUN groupadd -g 1000 graalvm && \
    useradd -m -u 1000 -g 1000 graalvm

USER graalvm
WORKDIR /home/graalvm