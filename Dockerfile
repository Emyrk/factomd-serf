FROM golang:1.10

RUN \
  apt-get update && \
  apt-get install -y vim python python-dev python-pip python-virtualenv && \
  pip install docker && \
  rm -rf /var/lib/apt/lists/*



RUN go get -u github.com/hashicorp/serf/cmd/serf

ENV GOPATH /go
WORKDIR /root/go/src/github.com/Emyrk/factomd-serf


COPY . .


# serf agent -node=$1 -config-dir=confs
ENTRYPOINT ["serf", "agent", "-config-dir=confs"]