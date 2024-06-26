#!/bin/bash

# Install prometheus stack with Helm

echo "Installing Prometheus stack..."

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack -n default -f monitoring_values.yaml
echo "Prometheus stack has been installed."
echo "---------------------------------------------------------------"

# Apply the serviceMonitors/PodMonitors to collect metrics from knative
echo "Applying serviceMonitors/PodMonitors to collect metrics from knative..."
kubectl apply -f https://raw.githubusercontent.com/knative-extensions/monitoring/main/servicemonitor.yaml

echo "Loading Grafana dashboards..."
kubectl apply -f https://raw.githubusercontent.com/knative-extensions/monitoring/main/grafana/dashboards.yaml

