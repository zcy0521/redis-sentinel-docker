# Redis

## Usage

- 启动

```shell script
git clone https://github.com/zcy0521/redis-sentinel-docker.git
cd redis-sentinel-docker
sudo docker-compose build --force-rm
sudo docker-compose up -d
sudo docker-compose ps
```

- 删除

```shell script
sudo docker-compose down
```

- 连接

```shell script
redis-cli -h 192.168.3.2 -p 26379
```

## Docker

### Install

- [Debian](https://docs.docker.com/engine/install/debian)

```shell script
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world
```

- [Ubuntu](https://docs.docker.com/engine/install/ubuntu/)

```shell script
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world
```

### Docker Compose

- [Linux](https://docs.docker.com/compose/install/#install-compose-on-linux-systems)

```shell script
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

### Docker run Redis

[Docker Hub](https://hub.docker.com/_/redis)

```shell script
docker run -d \
       --name redis \
       -p 26379:26379 \
       -v ./sentinel.conf:/usr/local/etc/redis/sentinel.conf \
       redis \
       redis-sentinel /usr/local/etc/redis/sentinel.conf
```
