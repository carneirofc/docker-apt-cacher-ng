#!/bin/bash
set -ex

create_pid_dir() {
  mkdir -p /run/apt-cacher-ng
  chmod -R 0755 /run/apt-cacher-ng
  chown ${APT_CACHER_NG_USER}:${APT_CACHER_NG_USER} /run/apt-cacher-ng
}

create_cache_dir() {
  mkdir -p ${APT_CACHER_NG_CACHE_DIR}
  chmod -R 0755 ${APT_CACHER_NG_CACHE_DIR}
  chown -R ${APT_CACHER_NG_USER}:root ${APT_CACHER_NG_CACHE_DIR}
}

create_log_dir() {
  mkdir -pv ${APT_CACHER_NG_LOG_DIR}
  touch ${APT_CACHER_NG_LOG_DIR}/apt-cacher.log
  touch ${APT_CACHER_NG_LOG_DIR}/apt-cacher.err
  chmod -R 0755 ${APT_CACHER_NG_LOG_DIR}
  chown -Rv ${APT_CACHER_NG_USER}:${APT_CACHER_NG_USER} ${APT_CACHER_NG_LOG_DIR}
}

create_pid_dir
create_cache_dir
create_log_dir

# default behaviour is to launch apt-cacher-ng
if [[ -z ${1} ]]; then
  echo "Redirect logs to stdout: "
  tail -f "${APT_CACHER_NG_LOG_DIR}/apt-cacher.err"&
  tail -f "${APT_CACHER_NG_LOG_DIR}/apt-cacher.log"&
  runuser \
      -u ${APT_CACHER_NG_USER} \
      -g ${APT_CACHER_NG_USER} \
      -- /usr/sbin/apt-cacher-ng -v -c ${APT_CACHER_NG_CONFIG} ${EXTRA_ARGS}
else
  exec "$@"
fi
