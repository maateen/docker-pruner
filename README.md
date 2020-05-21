# docker-pruner

Clean up all unused Docker containers, images (both dangling and unreferenced), networks, and volumes regularly.

## Usage

```shell script
$ docker run -d \
      --name docker-pruner \
      --restart=always \
      -e PRUNER_INTERVAL=24h \
      -v /var/run/docker.sock:/var/run/docker.sock \
      maateen/docker-pruner
```