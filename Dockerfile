FROM --platform=$BUILDPLATFORM golang:1.21.0-alpine AS builder
ARG TARGETOS
ARG TARGETARCH

WORKDIR /src/
COPY go.mod go.mod
COPY go.sum go.sum
COPY main.go main.go
RUN go mod download
RUN apk -U add binutils \
  && CGO_ENABLED=0 GOOS=${TARGETOS:-linux} GOARCH=${TARGETARCH} go build -o prometheus-logstash-exporter \
  && strip prometheus-logstash-exporter

FROM scratch
WORKDIR /
COPY --from=builder /src/prometheus-logstash-exporter /
USER 1000
EXPOSE 9304
ENTRYPOINT ["/prometheus-logstash-exporter"]
