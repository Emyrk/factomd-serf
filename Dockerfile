FROM golang:1.10

RUN go get -u github.com/hashicorp/serf/cmd/serf
