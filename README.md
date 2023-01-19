# Logstash exporter

Prometheus exporter for metrics provided by [Node Stats API](https://www.elastic.co/guide/en/logstash/current/monitoring-logstash.html) of Logstash.

## Building

*Golang must be installed on the local machine!*

```bash
$ git clone https://github.com/sap-contributions/prometheus-logstash-exporter.git
$ cd prometheus-logstash-exporter
$ CGO_ENABLED=0 go build -o prometheus-logstash-exporter
```

## Running

```bash
./prometheus-logstash-exporter <flags>
```

*If you hold Logstash defaults, the Exporter follow them too.*

To see all available configuration flags:

```bash
$ ./prometheus-logstash-exporter -h
Usage of ./prometheus-logstash-exporter:
  -logstash.host string
        Host address of logstash server. (default "localhost")
  -logstash.port int
        Port of logstash server. (default "9600")
  -logstash.timeout duration
        Timeout to get stats from logstash server. (default "5s")
  -web.listen-address string
        Address to listen on for web interface and telemetry. (default ":9304")
  -web.telemetry-path string
        Path under which to expose metrics. (default "/metrics")
```

In Kubernetes we recommend deploy the Exporter as a sidecar in pod with Logstash.

E.g.:
```yaml
...
spec:
  containers:
  - name: logstash
  (... setup for logstash ...)
  - name: exporter
    image: <PathToYourDockerContainerWithName>:<VersionForYourDockerContainer>
    args:
      - --web.listen-address=:9310 # by default is used port 9304, but feel free adapt this setting
    ports:
     - containerPort: 9310
       name: metrics
       protocol: TCP
    resources:
      requests:
        cpu: "100m"
        memory: "16M"
      limits:
        cpu: "200m"
        memory: "32M"
...
```
