FROM debian:stretch-slim

ENV JAVA_HOME /opt/graalvm
ENV GRAALVM_HOME /opt/graalvm
ENV NATIVE_IMAGE_CONFIG_FILE $GRAALVM_HOME/native-image.properties
ENV PATH /opt/apache-maven/bin:$JAVA_HOME/jre/bin:$GRAALVM_HOME/bin:$PATH

# All in one step, to reduce number of layers
RUN apt-get update && \
    apt-get -y install gcc libc6-dev zlib1g-dev curl git nano && \
    curl http://mirror.nbtelecom.com.br/apache/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz -o /tmp/maven.tar.gz && \
    tar -zxvf /tmp/maven.tar.gz -C /tmp && \
    mv /tmp/apache-maven-3.5.4 /opt/apache-maven && \
    curl -L https://github.com/oracle/graal/releases/download/vm-1.0.0-rc6/graalvm-ce-1.0.0-rc6-linux-amd64.tar.gz -o /tmp/graalvm.tar.gz && \
    tar -zxvf /tmp/graalvm.tar.gz -C /tmp && \
    mv /tmp/graalvm-ce-1.0.0-rc6 /opt/graalvm && \
    mvn install:install-file -Dfile=${JAVA_HOME}/jre/lib/svm/builder/svm.jar \
    -DgroupId=com.oracle.substratevm -DartifactId=svm -Dversion=GraalVM-1.0.0-rc6 -Dpackaging=jar && \
    mkdir -p /root/.native-image && \
    echo "NativeImageArgs = --no-server" > $GRAALVM_HOME/native-image.properties && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

WORKDIR /root
