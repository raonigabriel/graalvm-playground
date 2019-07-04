FROM debian:stretch-slim

LABEL org.label-schema.name="graalvm-playground" \
      org.label-schema.description="A docker image with GraalVM, JDK 1.8, Node, Maven and Git" \
      org.label-schema.vcs-url="https://github.com/raonigabriel/graalvm-playground" \
      org.label-schema.version="19.1.0"

ENV JAVA_HOME /opt/graalvm
ENV GRAALVM_HOME /opt/graalvm
ENV NATIVE_IMAGE_CONFIG_FILE $GRAALVM_HOME/native-image.properties
ENV PATH /opt/apache-maven/bin:$JAVA_HOME/jre/bin:$GRAALVM_HOME/bin:$PATH

# All in one step, to reduce number of layers
RUN apt-get update && \
    apt-get -y install gcc libc6-dev zlib1g-dev curl git nano upx-ucl && \
    curl http://mirror.nbtelecom.com.br/apache/maven/maven-3/3.6.1/binaries/apache-maven-3.6.1-bin.tar.gz -o /tmp/maven.tar.gz && \
    tar -zxvf /tmp/maven.tar.gz -C /tmp && \
    mv /tmp/apache-maven-3.6.1 /opt/apache-maven && \
    curl -L https://github.com/oracle/graal/releases/download/vm-19.1.0/graalvm-ce-linux-amd64-19.1.0.tar.gz -o /tmp/graalvm.tar.gz && \
    tar -zxvf /tmp/graalvm.tar.gz -C /tmp && \
    mv /tmp/graalvm-ce-19.1.0 /opt/graalvm && \
    gu install native-image && \
    mkdir -p /root/.native-image && \
    echo "NativeImageArgs = --no-server" > $GRAALVM_HOME/native-image.properties && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

WORKDIR /root
