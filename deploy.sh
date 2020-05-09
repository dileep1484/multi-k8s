docker build -t dileep1484/multi-client:latest -t dileep1484/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dileep1484/multi-server:latest -t dileep1484/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dileep1484/multi-worker:latest -t dileep1484/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dileep1484/multi-client:latest
docker push dileep1484/multi-server:latest
docker push dileep1484/multi-worker:latest
docker push dileep1484/multi-client:$SHA
docker push dileep1484/multi-server:$SHA
docker push dileep1484/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dileep1484/multi-server:$SHA
kubectl set image deployments/client-deployment client=dileep1484/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dileep1484/multi-worker:$SHA