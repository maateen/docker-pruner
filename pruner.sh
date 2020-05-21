#!/bin/sh

sleep_interval=${PRUNER_INTERVAL:-24h}

prune_containers() {
    echo "Deleting 'Dead' or 'Exited' containers."
    if [[ $(docker ps -aq -f status=exited -f status=dead) ]]; then
        docker rm -f $(docker ps -aq -f status=exited -f status=dead)
    else
        echo "No 'Dead' or 'Exited' container found."
    fi
}

prune_images() {
    echo "Deleting all dangling images"
    docker image prune --force
    echo "Deleting images with <none> as a tag name."
    if [[ $(docker images | grep -w "<none>" | awk '{print $3}') ]]; then
        docker rmi -f $(docker images | grep -w "<none>" | awk '{print $3}')
    else
        echo "No image found with <none> as a tag name."
    fi
    echo "Deleting all unused images created one month ago."
    docker image prune -a --force --filter "until=720h"
}

prune_networks() {
    echo "Deleting all custom networks not used by at least one container."
    docker network prune -f
}

prune_volumes() {
    echo "Deleting all local volumes not used by at least one container."
    docker volume prune -f
}

while true; do
    echo "Started at: $(date)"
    prune_containers
    prune_images
    prune_networks
    prune_volumes
    echo "End at: $(date)"
    sleep $sleep_interval
done