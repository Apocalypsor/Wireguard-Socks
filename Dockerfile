FROM alpine

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && apk add --update-cache dante-server wireguard-tools openresolv ip6tables tinyproxy\
  && rm -rf /var/cache/apk/*

COPY ./sockd.conf /etc/
COPY ./tinyproxy.conf /etc/
COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT "/entrypoint.sh"
