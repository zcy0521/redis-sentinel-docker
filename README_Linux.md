# Redis

## 安装

[Installation](https://redis.io/download#installation)

- 安装`Redis`

```
$ wget http://download.redis.io/releases/redis_6.0.6.tar.gz
$ tar xzf redis_6.0.6.tar.gz
$ cp -r redis_6.0.6 /usr/local/redis
$ cd /usr/local/redis
$ make
```

## 哨兵模式(sentinel)

[Sentinel](https://redis.io/topics/sentinel)

### Master节点

- redis_6379.conf

```
port 6379
daemonize yes
pidfile /var/run/redis_6379.pid
logfile "redis_6379.log"
dbfilename dump_6379.rdb

requirepass foobared

masterauth foobared
```

> 当使用了sentinel时，由于一个master可能会变成一个slave，一个slave也可能会变成master，所以`master节点`需要同时设置`requirepass` `masterauth`

- 启动(设置logfile后启动画面不会输入到`控制台`而是`logfile`)

```
$ redis-server redis_6379.conf
```

### Replica节点

[Replication](https://redis.io/topics/replication)

- redis_6380.conf

```
port 6380
daemonize yes
pidfile /var/run/redis_6380.pid
logfile "redis_6380.log"
dbfilename dump_6380.rdb

requirepass foobared

replicaof 127.0.0.1 6379
masterauth foobared
```

- redis_6381.conf

```
port 6381
daemonize yes
pidfile /var/run/redis_6381.pid
logfile "redis_6381.log"
dbfilename dump_6381.rdb

requirepass foobared

replicaof 127.0.0.1 6379
masterauth foobared
```

> replica通过 `masterauth` 来设置访问master时的密码。

- 启动

```
$ redis-server redis_6380.conf
$ redis-server redis_6381.conf
```

### Sentinel节点

- sentinel_26379.conf `sentinel节点`

```
port 26379
daemonize yes
pidfile /var/run/redis-sentinel_26379.pid
logfile "redis-sentinel_26379.log"

sentinel monitor mymaster 127.0.0.1 6379 2
sentinel auth-pass mymaster foobared
```

- sentinel_26380.conf `sentinel节点`

```
port 26380
daemonize yes
pidfile /var/run/redis-sentinel_26380.pid
logfile "redis-sentinel_26380.log"

sentinel monitor mymaster 127.0.0.1 6379 2
sentinel auth-pass mymaster foobared
```

- sentinel_26381.conf `sentinel节点`

```
port 26381
daemonize yes
pidfile /var/run/redis-sentinel_26381.pid
logfile "redis-sentinel_26381.log"

sentinel monitor mymaster 127.0.0.1 6379 2
sentinel auth-pass mymaster foobared
```

> sentinel永远会记录好一个Master的slaves，即使slave已经与组织失联好久了。因为sentinel集群必须有能力把一个恢复可用的slave进行重新配置。并且failover后，失效的master将会被标记为新master的一个slave，当它变得可用时，就会从新master上复制数据。

> 有时候你想要永久地删除掉一个slave(有可能它曾经是个master)，只需要发送一个 `SENTINEL RESET master` 命令给所有的sentinels，它们将会更新列表里能够正确地复制master数据的slave。

- 启动

```
$ redis-server sentinel_6379.conf --sentinel
$ redis-server sentinel_6380.conf --sentinel
$ redis-server sentinel_6381.conf --sentinel
```

## 集群模式(cluster)

[Cluster](https://redis.io/topics/cluster-tutorial)

### Cluster节点

- redis_7000.conf

```
port 7000
daemonize yes
pidfile /var/run/redis_7000.pid
logfile "redis_7000.log"
dbfilename dump_7000.rdb

requirepass foobared

masterauth foobared

cluster-enabled yes
cluster-config-file nodes-7000.conf
cluster-node-timeout 5000
```

- redis_7001.conf

```
port 7001
daemonize yes
pidfile /var/run/redis_7001.pid
logfile "redis_7001.log"
dbfilename dump_7001.rdb

requirepass foobared

masterauth foobared

cluster-enabled yes
cluster-config-file nodes-7001.conf
cluster-node-timeout 5000
```

- redis_7002.conf

```
port 7002
daemonize yes
pidfile /var/run/redis_7002.pid
logfile "redis_7002.log"
dbfilename dump_7002.rdb

requirepass foobared

masterauth foobared

cluster-enabled yes
cluster-config-file nodes-7002.conf
cluster-node-timeout 5000
```

- redis_7003.conf

```
port 7003
daemonize yes
pidfile /var/run/redis_7003.pid
logfile "redis_7003.log"
dbfilename dump_7003.rdb

requirepass foobared

masterauth foobared

cluster-enabled yes
cluster-config-file nodes-7003.conf
cluster-node-timeout 5000
```

- redis_7004.conf

```
port 7004
daemonize yes
pidfile /var/run/redis_7004.pid
logfile "redis_7004.log"
dbfilename dump_7004.rdb

requirepass foobared

masterauth foobared

cluster-enabled yes
cluster-config-file nodes-7004.conf
cluster-node-timeout 5000
```

- redis_7005.conf

```
port 7005
daemonize yes
pidfile /var/run/redis_7005.pid
logfile "redis_7005.log"
dbfilename dump_7005.rdb

requirepass foobared

masterauth foobared

cluster-enabled yes
cluster-config-file nodes-7005.conf
cluster-node-timeout 5000
```

- 启动

```
$ redis-server redis_7000.conf
$ redis-server redis_7001.conf
$ redis-server redis_7002.conf
$ redis-server redis_7003.conf
$ redis-server redis_7004.conf
$ redis-server redis_7005.conf
```

### 设置集群

- Redis3/4

```
redis-trib.rb create --replicas 1 127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005
```

- Redis5/6

```
redis-cli --cluster create 127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005 --cluster-replicas 1
```
