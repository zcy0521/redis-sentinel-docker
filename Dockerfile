FROM redis

WORKDIR /usr/local/etc/redis
COPY conf/sentinel.conf .

ENTRYPOINT ["redis-server", "sentinel.conf", "--sentinel"]