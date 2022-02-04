FROM debian:11.2-slim

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
      apt-cacher-ng ca-certificates tzdata wget \
 && rm -rf /var/lib/apt/lists/*


ENV APT_CACHER_NG_USER=apt-cacher-ng \
    APT_CACHER_NG_CACHE_DIR=/var/cache/apt-cacher-ng \
    APT_CACHER_NG_LOG_DIR=/var/log/apt-cacher-ng \
    APT_CACHER_NG_USER=apt-cacher-ng \
    APT_CACHER_NG_CONFIG=/opt/apt-cacher-ng

HEALTHCHECK --interval=10s --timeout=2s --retries=3 \
    CMD wget -q -t1 -O /dev/null  http://localhost:3142/acng-report.html || exit 1

COPY entrypoint.sh /sbin/entrypoint.sh

COPY acng.conf ${APT_CACHER_NG_CONFIG}/acng.conf

RUN chmod 755 /sbin/entrypoint.sh && \
    mkdir -p -v ${APT_CACHER_NG_CONFIG} && \
    chown -v ${APT_CACHER_NG_USER}:${APT_CACHER_NG_USER} ${APT_CACHER_NG_CONFIG}/acng.conf

EXPOSE 3142/tcp

VOLUME ["${APT_CACHER_NG_CACHE_DIR}", "${APT_CACHER_NG_LOG_DIR}"]

ENTRYPOINT ["/sbin/entrypoint.sh"]
