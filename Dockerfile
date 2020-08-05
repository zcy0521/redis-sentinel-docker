FROM redis
COPY sentinel.conf /usr/local/etc/redis/sentinel.conf
ENTRYPOINT [ "redis-sentinel", "/usr/local/etc/redis/sentinel.conf" ]