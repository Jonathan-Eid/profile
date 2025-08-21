#!/bin/bash

# A simple bash function to port-forward a Kubernetes service.
#
# Usage: kpf <service_name> <local_port> [namespace] [remote_port]
#
# Arguments:
#   <service_name> - The full name of the Kubernetes service to forward. (required)
#   <local_port>   - The local port on your machine to forward to the service. (required)
#   [namespace]    - The namespace of the service. Defaults to 'tec'. (optional)
#   [remote_port]  - The internal service port to forward. Defaults to '80'. (optional)
#
# Examples:
#   # Using default namespace and remote port
#   kpf beta-theta-edge-cloud-coordinator-svc 8080
#
#   # Specifying a custom namespace
#   kpf my-other-service 9090 my-other-namespace
#
#   # Specifying both a custom namespace and remote port
#   kpf my-other-service 9090 my-other-namespace 8080

alias kapow="kubectl get pods -A -o wide"

kpf() {
  # Check for the two required arguments.
  if [ "$#" -lt 2 ]; then
    echo "Usage: kpf <service_name> <local_port> [namespace] [remote_port]"
    echo ""
    echo "Arguments:"
    echo "  <service_name> - The full name of the Kubernetes service to forward. (required)"
    echo "  <local_port>   - The local port on your machine to forward to the service. (required)"
    echo "  [namespace]    - The namespace of the service. Defaults to 'tec'."
    echo "  [remote_port]  - The internal service port to forward. Defaults to '80'."
    return 1
  fi

  local service_name="$1"
  local local_port="$2"
  local namespace="${3:-tec}"      # Use 'tec' as the default if a third argument isn't provided.
  local remote_port="${4:-80}"     # Use '80' as the default if a fourth argument isn't provided.

  echo "Starting port-forward for service/$service_name in namespace $namespace..."
  echo "Forwarding local port $local_port to service port $remote_port."

  # Execute the port-forward command with the dynamic variables.
  kubectl port-forward -n "$namespace" "svc/$service_name" "$local_port:$remote_port"
}
