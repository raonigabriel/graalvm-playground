FROM debian:stretch-slim

# Update and install dependencies and download and install Maven
ARG DEBIAN_FRONTEND=noninteractive
ARG MAVEN_VERSION=3.6.3
ARG MAVEN_PKG=https://downloads.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz
ENV MAVEN_HOME=/opt/apache-maven-$MAVEN_VERSION
RUN apt-get update && \
    apt-get -y --no-install-recommends install ca-certificates gcc libc6-dev zlib1g-dev curl git nano upx-ucl musl-tools && \
    rm -rf /var/lib/apt/lists/* && \
    curl -s -L $MAVEN_PKG | tar -xz -C /opt

# Download and install GraalVM (also adds native-image and wasm)]
# This is on a diferent layer on purpose (take advantage of caching for java8 and java11 versions)
ARG GRAALVM_VERSION=21.1.0
ARG GRAALVM_PKG=https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-$GRAALVM_VERSION/graalvm-ce-java8-linux-amd64-$GRAALVM_VERSION.tar.gz
ENV JAVA_HOME=/opt/graalvm-ce-java8-$GRAALVM_VERSION
ENV PATH=$MAVEN_HOME/bin:$JAVA_HOME/jre/bin:$JAVA_HOME/bin:$PATH
RUN curl -s -L $GRAALVM_PKG | tar -xz -C /opt && \
    gu install native-image wasm

# Metadata
LABEL org.label-schema.schema-version = "1.0" \
      org.label-schema.name="graalvm-playground-java11" \
      org.label-schema.description="A docker image with GraalVM, OpenJDK, Maven and Git" \
      org.label-schema.vcs-url="https://github.com/raonigabriel/graalvm-playground" \
      org.label-schema.version="$GRAALVM_VERSION-java8"

WORKDIR /root
