docker build -t letsya68/multi-client:latest -t letsya68/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t letsya68/multi-server:latest -t letsya68/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t letsya68/multi-worker:latest -t letsya68/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push letsya68/multi-client:latest
docker push letsya68/multi-server:latest
docker push letsya68/multi-worker:latest

docker push letsya68/multi-client:$SHA
docker push letsya68/multi-server:$SHA
docker push letsya68/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=letsya68/multi-server:$SHA
kubectl set image deployments/client-deployment client=letsya68/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=letsya68/multi-worker:$SHA
