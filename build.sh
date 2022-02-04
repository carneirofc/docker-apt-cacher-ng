#!/bin/sh
set -exu
branch=$(git branch --no-color --show-current)
build_date=$(date -I)
build_date_RFC339=$(date --rfc-3339=seconds)
commit=$(git rev-parse --short HEAD)
repository=$(git remote show origin |grep Fetch|awk '{ print $3 }')

tag=carneirofc/apt-cacher-ng:${commit}-${build_date}

docker build \
    --label "org.opencontainers.image.authors=Claudio F. Carneiro <claudiofcarneiro@hotmail.com>" \
    --label "org.opencontainers.image.created=${build_date_RFC339}" \
    --label "org.opencontainers.image.description=Debian buster with apt-cacher-ng" \
    --label "org.opencontainers.image.licenses=Apache-2.0" \
    --label "org.opencontainers.image.revision=" \
    --label "org.opencontainers.image.revision=${commit}" \
    --label "org.opencontainers.image.source=${repository}" \
    --label "org.opencontainers.image.title=apt-cacher-ng" \
    --label "org.opencontainers.image.url=${repository}" \
    --label "org.opencontainers.image.vendor=carneirofc" \
    --label "org.opencontainers.image.version=${tag}" \
    --tag ${tag} \
    .

sed -i "s,image:.*,image: ${tag},g" ./docker-compose.yml
