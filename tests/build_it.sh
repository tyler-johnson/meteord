#!/bin/bash
set -x

: ${NODE_VERSION?"NODE_VERSION has not been set."}

docker build --build-arg "NODE_VERSION=${NODE_VERSION}" -t "mrgalaxy/meteord:node-${NODE_VERSION}-base" ../base && \
  docker tag "mrgalaxy/meteord:node-${NODE_VERSION}-base" mrgalaxy/meteord:base
docker build --build-arg "NODE_VERSION=${NODE_VERSION}" -t "mrgalaxy/meteord:node-${NODE_VERSION}-onbuild" ../onbuild && \
  docker tag "mrgalaxy/meteord:node-${NODE_VERSION}-onbuild" mrgalaxy/meteord:onbuild
docker build --build-arg "NODE_VERSION=${NODE_VERSION}" -t "mrgalaxy/meteord:node-${NODE_VERSION}-devbuild" ../devbuild && \
  docker tag "mrgalaxy/meteord:node-${NODE_VERSION}-devbuild" mrgalaxy/meteord:devbuild
docker build --build-arg "NODE_VERSION=${NODE_VERSION}" -t "mrgalaxy/meteord:node-${NODE_VERSION}-binbuild" ../binbuild && \
  docker tag "mrgalaxy/meteord:node-${NODE_VERSION}-binbuild" mrgalaxy/meteord:binbuild
