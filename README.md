# kafka-prometheus-monitoring
Dockerised example of monitoring [Apache Kafka](https://kafka.apache.org/) with [Prometheus](https://prometheus.io/) and [Grafana](http://grafana.org/).  This project makes use of the prometheus-jmx-exporter which is configured to extract metrics from Kafka's JMX server.  These metrics are then exposed via HTTP GET and polled by Prometheus.

## Pre-Requisites
* Install Docker and Docker Compose - https://docs.docker.com/

## Usage

```
docker-compose up
```

- View Prometheus UI - `http://localhost:9090`
- Grafana UI - `http://localhost:3000` (admin:foobar)
- Kafka metrics - `http://localhost:8080/metrics`

### Viewing Prometheus Metrics
The kafka metrics are pulled into Prometheus via the JMX exporter.  These can be viewed in Prometheus by navigating to `http://localhost:9090/graph`, enter a metric name to view the graphs.

### Viewing Graphs in Grafana
Grafana can be used to build a more meaningful dashboard of the metrics in Prometheus, navigate to Grafana on `http://localhost:3000` (admin:foobar).
