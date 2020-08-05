FROM redis

WORKDIR /usr/local/etc/redis
COPY conf/sentinel.conf .

CMD ["redis-server", "/etc/redis/rediscluster.conf", "--sentinel"]