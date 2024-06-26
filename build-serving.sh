# Set environment variables
export KO_DOCKER_REPO='docker.io/tarikkada'
# export YAML_OUTPUT_DIR="./knative-serving/generated-yamls"

bash knative-serving/hack/generate-yamls.sh ./knative-serving list_of_yamls.txt
