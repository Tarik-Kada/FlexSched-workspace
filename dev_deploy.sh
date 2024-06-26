bash create_cluster.sh

cd custom-schedulers/simple-flask
bash deploy.sh
cd .. && cd ..

cd custom-scheduler-controller/hack
bash build.sh
bash deploy.sh
cd ../..

bash deploy_serving.sh

bash deploy_prometheus.sh
