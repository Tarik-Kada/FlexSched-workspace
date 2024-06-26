#!/bin/bash

# List of values to loop over
# values=(1 5 10 25 50 100)
values=(100)

# Number of iterations per value
iterations=5

# Function to wait for pods to be in the running state
wait_for_pods_running() {
  local value=$1
  local desired_pods=$2

  while true; do
    running_pods=$(kubectl get pods -n default --field-selector=status.phase=Running --no-headers | grep "hello-${value}-" | grep "2/2" | wc -l)
    if [[ $running_pods -eq $desired_pods ]]; then
      echo "All $desired_pods pods for value $value are running and ready (2/2)."
      break
    else
      echo "Waiting for pods to be running and ready (2/2). Currently: $running_pods/$desired_pods"
      sleep 10
    fi
  done
}

# Function to wait for pods to be deleted
wait_for_pods_deleted() {
  local value=$1

  while true; do
    existing_pods=$(kubectl get pods -n default --no-headers | grep "hello-${value}-" | wc -l)
    if [[ $existing_pods -eq 0 ]]; then
      echo "All pods for value $value have been deleted."
      break
    else
      echo "Waiting for pods to be deleted. Currently existing: $existing_pods"
      sleep 10
    fi
  done
}

cd test_functions/services

# Main loop over the values
for value in "${values[@]}"; do
  for ((i=1; i<=iterations; i++)); do
    echo "Iteration $i for value $value"

    # Apply the configuration
    kubectl apply -f hello-${value}.yaml

    # Wait for the desired number of pods to be running
    wait_for_pods_running $value $value

    # Delete the configuration
    kubectl delete -f hello-${value}.yaml

    # Wait for all pods to be deleted
    wait_for_pods_deleted $value
  done
done

echo "Script completed."
cd ../..