# apt-cacher-ng-docker
Docker image for apt-cacher-ng.

apt-cacher-ng is a nice little software to create a local cache of the Debian mirrors (but it can also operate on other distribution mirrors). 

Dockerhub at https://hub.docker.com/repository/docker/carneirofc/apt-cacher-ng

Labels according to https://github.com/opencontainers/image-spec/blob/master/annotations.md#rules

apt-cacher-ng https://www.unix-ag.uni-kl.de/~bloch/acng/html/

## Client
Create a file with:
```
# file: /etc/apt/apt.conf.d/proxy
Acquire::http { Proxy "http://<server_ip>:3142"; }
Acquire::https { Proxy "DIRECT"; }
```
