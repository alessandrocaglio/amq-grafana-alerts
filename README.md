# AMQ Broker Grafana alert dashboard

Simple helm chart that provides custom grafana dashboard to set up basic alerting on queue metrics (min-consumer, max-depth)

## Prerequisite
Grafana and AMQ Broker installed and metrics collected into prometheus.

## Default Values
``` yaml
monitoredNamespace: default
brokerInstance: artemis-broker
service: "service1"
dashboardName: "Service1 Queues Alert"
uid: service1queuealerts
queues:
  - name: queue1
    minConsumer: 1
    maxDepth: 88
  - name: queue2
    minConsumer: 1
    maxDepth: 99
  - name: queue3
    minConsumer: 1
    maxDepth: 99

nameOverride: ""
fullnameOverride: ""
```

## Install
Install using helm template and oc(kubectl) apply
`helm template -n $GRAFANA_NAMESPACE demo-dashboard ./amq-grafana-alert -f $MY_CUSTOM_VALUES.yaml | oc apply -n $GRAFANA_NAMESPACE -f-`

Install using helm (dry-run)
`helm upgrade --install -n $GRAFANA_NAMESPACE demo-dashboard ./amq-grafana-alert -f $MY_CUSTOM_VALUES.yaml --dry-run`

Install using helm 
`helm upgrade --install -n $GRAFANA_NAMESPACE demo-dashboard ./amq-grafana-alert -f $MY_CUSTOM_VALUES.yaml`