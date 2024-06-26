minikube start --nodes=4 --cpus=4 --memory=2048

cd custom-schedulers/simple-flask
bash deploy.sh
cd .. && cd ..

cd custom-scheduler-controller/hack
bash build.sh
bash deploy.sh
cd ../..

bash deploy_serving.sh

bash deploy_prometheus.sh
