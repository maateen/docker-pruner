FROM docker:stable-dind

ENV PRUNER_INTERVAL=24h

WORKDIR /docker

ADD . .

CMD /bin/sh /docker/pruner.sh