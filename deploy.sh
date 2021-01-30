docker build -t kudeh/multi-client:latest -t kudeh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kudeh/multi-server:latest -t kudeh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kudeh/multi-worker:latest -t kudeh/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kudeh/multi-client:latest
docker push kudeh/multi-server:latest
docker push kudeh/multi-worker:latest

docker push kudeh/multi-client:$SHA
docker push kudeh/multi-server:$SHA
docker push kudeh/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kudeh/multi-server:$SHA
kubectl set image deployments/client-deployment client=kudeh/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kudeh/multi-worker:$SHA