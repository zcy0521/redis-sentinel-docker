FROM redis

WORKDIR /usr/local/etc/redis
COPY sentinel.conf .

CMD ["redis-server", "/etc/redis/rediscluster.conf", "--sentinel"]