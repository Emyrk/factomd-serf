FROM golang:1.10

RUN go get -u github.com/hashicorp/serf/cmd/serf
RUN go get -d github.com/Emyrk/factomd-serf

WORKDIR $GOPATH/src/github.com/Emyrk/factomd-serf

ENTRYPOINT ["./start_factomd.sh"]