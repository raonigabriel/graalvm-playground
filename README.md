# graalvm-playground
A docker image with GraalVM, JDK 1.8, Node, Maven and Git

[![Docker Automated build](https://img.shields.io/docker/automated/raonigabriel/graalvm-playground.svg)](https://hub.docker.com/r/raonigabriel/graalvm-playground/)
[![ImageLayers Size](https://img.shields.io/imagelayers/image-size/raonigabriel/graalvm-playground/latest.svg)](https://hub.docker.com/r/raonigabriel/graalvm-playground/)

## Features
Based on debian:stretch-slim
GraalVM CE 1.0.0-rc6
JDK 1.8.0_172
Maven 3.5.4
Node 8.11.1
Git 2.11.0

## Usage
Best used if you mount your home to /root, as follows:
```
$ docker run --rm  -v ~/:/root -it raonigabriel/graalvm-playground /bin/bash
root@be7deb9a56de:~# mvn --version
```
## Source
https://github.com/raonigabriel/graalvm-playground

## Disclaimer
This image is just a playground, a toy: it is not suposed to run serious stuff.
