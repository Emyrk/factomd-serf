#!/bin/sh

docker run -p 7948:7948 -it -v /var/run/docker.sock:/var/run/docker.sock --net=host --name serf-control serf-control --bind 0.0.0.0:7948