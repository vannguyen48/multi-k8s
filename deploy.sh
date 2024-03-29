docker build -t vnguyen0804/multi-client:latest -t vnguyen0804/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vnguyen0804/multi-server:latest -t vnguyen0804/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vnguyen0804/multi-worker:latest -t vnguyen0804/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vnguyen0804/multi-client:latest
docker push vnguyen0804/multi-server:latest
docker push vnguyen0804/multi-worker:latest

docker push vnguyen0804/multi-client:$SHA
docker push vnguyen0804/multi-server:$SHA
docker push vnguyen0804/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vnguyen0804/multi-server:$SHA
kubectl set image deployments/client-deployment client=vnguyen0804/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vnguyen0804/multi-worker:$SHA
