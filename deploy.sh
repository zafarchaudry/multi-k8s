#deploy script
docker build -t zafarchaudry/multi-client:latest -t zafarchaudry/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t zafarchaudry/multi-server:latest -t zafarchaudry/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t zafarchaudry/multi-worker:latest -t zafarchaudry/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push zafarchaudry/multi-client:latest
docker push zafarchaudry/multi-server:latest
docker push zafarchaudry/multi-client$SHA
docker push zafarchaudry/multi-worker:latest
docker push zafarchaudry/multi-server:$SHA
docker push zafarchaudry/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=zafar/multi-server:$SHA
kubectl set image deployments/server-deployment worker=zafar/multi-worker$SHA
kubectl set image deployments/server-deployment client=zafar/multi-client:$SHA
