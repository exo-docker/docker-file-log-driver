FROM golang:1.17-alpine

RUN apk update && \
	apk add git

WORKDIR /go/src/github.com/exo-docker/docker-file-log-driver

RUN go get github.com/docker/docker/api/types/plugins/logdriver
RUN go get github.com/docker/docker/daemon/logger
RUN go get github.com/docker/docker/daemon/logger/loggerutils
RUN go get github.com/docker/go-plugins-helpers/sdk
RUN go get github.com/pkg/errors
RUN go get github.com/sirupsen/logrus
RUN go get github.com/containerd/fifo
RUN go get github.com/gogo/protobuf/io
RUN go get github.com/snowzach/rotatefilehook

COPY . /go/src/github.com/exo-docker/docker-file-log-driver
RUN go mod init
RUN go get
RUN go build --ldflags '-extldflags "-static"' -o /usr/bin/docker-file-log-driver
