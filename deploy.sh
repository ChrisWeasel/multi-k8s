docker build -t cratclif/multi-client:latest -t cratclif/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cratclif/multi-server:latest -t cratclif/multi-server:$SHA -f ./client/Dockerfile ./server
docker build -t cratclif/multi-worker:latest -t cratclif/multi-worker:$SHA -f ./client/Dockerfile ./worker
docker push cratclif/multi-client:latest
docker push cratclif/multi-client:$SHA
docker push cratclif/multi-server:latest
docker push cratclif/multi-server:$SHA
docker push cratclif/multi-worker:latest
docker push cratclif/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cratclif/multi-server:$SHA
kubectl set image deployments/client-deployment client=cratclif/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cratclif/multi-worker:$SHA