FROM redis

COPY conf/sentinel.conf /usr/local/etc/redis/sentinel.conf
RUN chown redis:redis /usr/local/etc/redis/sentinel.conf

ENTRYPOINT ["redis-server", "/usr/local/etc/redis/sentinel.conf", "--sentinel"]