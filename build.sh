#!/bin/sh
set -ex
docker pull debian:buster-slim

branch=$(git branch --no-color --show-current)
build_date=$(date -I)
commit=$(git rev-parse --short HEAD)
repository=$(git remote show origin |grep Fetch|awk '{ print $3 }')
tag=carneirofc/apt-cacher-ng:${build_date}

docker build \
    --label repository.commit=${commit} \
    --label repository.branch=${branch} \
    --label repository=${repository} \
    --label maintainer.name="Claudio F. Carneiro" \
    --label maintainer.email="claudiofcarneiro@hotmail.com" \
    --tag ${tag} \
    .

sed -i "s,image:.*,image: ${tag},g" ./docker-compose.yml
