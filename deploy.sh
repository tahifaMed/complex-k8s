docker build -t tahifamed/multi-client:latest -t tahifamed/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tahifamed/multi-server:latest -t tahifamed/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tahifamed/multi-worker:latest -t tahifamed/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tahifamed/multi-client:latest
docker push tahifamed/multi-client:$SHA
docker push tahifamed/multi-server:latest
docker push tahifamed/multi-server:$SHA
docker push tahifamed/multi-worker:latest
docker push tahifamed/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tahifamed/multi-server:$SHA
kubectl set image deployments/client-deployment client=tahifamed/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tahifamed/multi-worker:$SHA