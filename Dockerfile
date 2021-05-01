FROM   debian:buster-slim

VOLUME ["/var/cache/apt-cacher-ng"]
RUN    apt-get update && apt-get install -y apt-cacher-ng tzdata

EXPOSE 3142
COPY   acng.conf /etc/apt-cacher-ng/acng.confc/etc/apt-ccher-ng/acng.conf
CMD    chmod 777 /var/cache/apt-cacher-ng && /etc/init.d/apt-cacher-ng start && tail -f /var/log/apt-cacher-ng/*
