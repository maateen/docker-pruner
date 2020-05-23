# docker-pruner

Clean up all unused Docker containers, images (both dangling and unreferenced), networks, and volumes regularly.

## What it prunes?

- Container
    - Dead
    - Exited
- Image
    - Dangling
    - None tag
    - Unused
        - Created before 1 month
- Network
    - Custom
        - Unused
- Volume
    - Local
        - Unsed

## Minimum Requirements

- Docker Server
    - Version: 18.06.1-ce
    - API version: 1.38

## Usage

### Standalone Docker

```shell script
$ docker run -d \
      --name docker-pruner \
      --restart=always \
      -e PRUNER_INTERVAL=24h \
      -v /var/run/docker.sock:/var/run/docker.sock \
      maateen/docker-pruner
```

### K8s Cluster

```shell script
$ kubectl apply -f https://raw.githubusercontent.com/maateen/docker-pruner/master/k8s.yml
```