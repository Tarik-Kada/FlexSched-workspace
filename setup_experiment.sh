minikube start --nodes=4 --cpus=2 --memory=2048

bash quick_start.sh
# bash quick_start_base.sh

cd custom-schedulers/round-robin
bash deploy.sh
cd .. && cd ..

cd logging/pod-logger
bash deploy.sh
cd .. && cd ..
