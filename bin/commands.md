# Useful CLI stuff

```
minikube addons enable ingress

kubectl config set-context minikube --namespace=local-dev

kubectl config use-context minikube --namespace=local-dev

kubectl delete deployment.apps/api-directory service/api-directory

kubectl port-forward deployment/api-directory 8081:3123

minikube service api-directory -n local-dev --url

minikube ip

```