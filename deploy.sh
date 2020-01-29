docker build -t ukernel/multi-client:latest -t ukernel/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ukernel/multi-server:latest -t ukernel/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ukernel/multi-worker:latest -t ukernel/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ukernel/multi-client:latest 
docker push ukernel/multi-server:latest
docker push ukernel/multi-worker:latest

docker push ukernel/multi-client:$SHA
docker push ukernel/multi-server:$SHA
docker push ukernel/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ukernel/multi-server:$SHA
kubectl set image deployments/client-deployment client=ukernel/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ukernel/multi-worker:$SHA