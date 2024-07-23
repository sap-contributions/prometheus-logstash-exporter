# Logstash exporter


[![REUSE status](https://api.reuse.software/badge/github.com/SAP/prometheus-logstash-exporter)](https://api.reuse.software/info/github.com/SAP/prometheus-logstash-exporter)

## About this project

Prometheus exporter for metrics provided by [Node Stats API](https://www.elastic.co/guide/en/logstash/current/monitoring-logstash.html) of Logstash.

## Requirements and Building

*Golang must be installed on the local machine!*

```bash
$ git clone https://github.com/sap/prometheus-logstash-exporter.git
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
    image: ghcr.io/sap/prometheus-logstash-exporter:latest
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

## Support, Feedback, Contributing

This project is open to feature requests/suggestions, bug reports etc. via [GitHub issues](https://github.com/SAP/prometheus-logstash-exporter/issues). Contribution and feedback are encouraged and always welcome. For more information about how to contribute, the project structure, as well as additional contribution information, see our [Contribution Guidelines](CONTRIBUTING.md).

## Code of Conduct

We as members, contributors, and leaders pledge to make participation in our community a harassment-free experience for everyone. By participating in this project, you agree to abide by its [Code of Conduct](https://github.com/SAP/.github/blob/main/CODE_OF_CONDUCT.md) at all times.

## Licensing

Copyright (20xx-)20xx SAP SE or an SAP affiliate company and <your-project> contributors. Please see our [LICENSE](LICENSE) for copyright and license information. Detailed information including third-party components and their licensing/copyright information is available [via the REUSE tool](https://api.reuse.software/info/github.com/SAP/prometheus-logstash-exporter).

DUMMY_VALUE
