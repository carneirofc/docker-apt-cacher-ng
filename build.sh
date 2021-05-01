#!/bin/sh
set -ex
docker pull debian:buster-slim
docker build --tag carneirofc/apt-cacher-ng:$(date -I) .
