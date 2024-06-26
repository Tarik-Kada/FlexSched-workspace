# Use already built manifests to quickly deploy necessary components to the cluster.

# Deploy the custom scheduler controller
kubectl apply -f https://github.com/Tarik-Kada/custom-scheduler-controller/releases/download/v1.0.0/install.yaml

# Deploy knative-serving
kubectl apply -f https://github.com/Tarik-Kada/knative-serving/releases/download/v1.0.0/serving-crds.yaml
kubectl apply -f https://github.com/Tarik-Kada/knative-serving/releases/download/v1.0.0/serving-core.yaml

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack -n default -f monitoring_values.yaml
echo "Prometheus stack has been installed."
echo "---------------------------------------------------------------"

# Apply the serviceMonitors/PodMonitors to collect metrics from knative
kubectl apply -f https://raw.githubusercontent.com/knative-extensions/monitoring/main/servicemonitor.yaml
