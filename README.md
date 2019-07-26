# graalvm-playground
A docker image with GraalVM, JDK 1.8, Node, Maven and Git

[![Docker Automated build](https://img.shields.io/docker/automated/raonigabriel/graalvm-playground.svg)](https://hub.docker.com/r/raonigabriel/graalvm-playground/)
[![MicroBadger Size](https://images.microbadger.com/badges/image/raonigabriel/graalvm-playground.svg)](https://microbadger.com/images/raonigabriel/graalvm-playground)
[![MicroBadger Version](https://images.microbadger.com/badges/version/raonigabriel/graalvm-playground.svg)](https://microbadger.com/images/raonigabriel/graalvm-playground)

## Features
- Based on [debian:stretch-slim](https://hub.docker.com/r/library/debian/)
- GraalVM CE [19.1.1](https://github.com/oracle/graal/releases/tag/vm-19.1.1)
- OpenJDK 1.8.0_212
- Maven 3.6.1
- Node 10.15.2
- Git 2.11.0
- Upx 3.9.1

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
