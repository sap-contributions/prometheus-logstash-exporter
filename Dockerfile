FROM golang:1.23.5-alpine AS builder
WORKDIR /src/
COPY go.mod go.mod
COPY go.sum go.sum
COPY main.go main.go
RUN go mod download
RUN apk -U add binutils && CGO_ENABLED=0 go build -o prometheus-logstash-exporter && strip prometheus-logstash-exporter

FROM scratch
WORKDIR /
COPY --from=builder /src/prometheus-logstash-exporter /
USER 1000
EXPOSE 9304
ENTRYPOINT ["/prometheus-logstash-exporter"]
