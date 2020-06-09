# graalvm-playground
A docker image with GraalVM, OpenJDK, Node, Maven and Git

![Docker Build](https://github.com/raonigabriel/graalvm-playground/workflows/Docker%20Build/badge.svg)
[![MicroBadger Size](https://images.microbadger.com/badges/image/raonigabriel/graalvm-playground.svg)](https://microbadger.com/images/raonigabriel/graalvm-playground)
[![MicroBadger Version](https://images.microbadger.com/badges/version/raonigabriel/graalvm-playground.svg)](https://microbadger.com/images/raonigabriel/graalvm-playground)

## Tags
Beggining with GraalVM 20.0.0, there will be 2 diferent versions (tags) of this image: java8 (remains as the **latest tag** ) and java11 
Therefore, you can docker pull **raonigabriel/graalvm-playground:20.1.0-java8** or **raonigabriel/graalvm-playground:20.1.0-java11**

## Features
- Based on [debian:stretch-slim](https://hub.docker.com/r/library/debian/)
- GraalVM CE [20.1.0](https://github.com/oracle/graal/releases/tag/vm-20.1.0)
- OpenJDK 8u252 or OpenJDK 11.0.7
- Maven 3.6.3
- Node 12.15.0
- Git 2.11.0
- Upx 3.91

## Usage
Best used if you mount your home to /root, as follows:
```
$ docker run --rm  -v ~/:/root -it raonigabriel/graalvm-playground /bin/bash
root@be7deb9a56de:~# mvn --version
```
## Source
https://github.com/raonigabriel/graalvm-playground

## Disclaimer
This image is just a playground, a toy: it is not supposed to run serious stuff.
