# rrmerugu/homelab

This repository contains code and documentation of my homelab - a private compute and storage infrastructure.


Key focus is on:

1. Have control over my data.
2. Avoid being tracked by interenet (let's will try the best options )
3. Learning setting up and monitoring self-hosted infrastructure  


## Install local DNS



## 1. Install K3s+Rancher

### Setup k3s + Rancher

```
sudo apt -y update

# install k3s-server
export K3S_URL=https://k3s.localhost.local:6443
sh scripts/k3s/install-k3s-server.sh

# install helm
sh scripts/helm/install-helm.sh

# install rancher 
sh scripts/rancher/install-rancher.sh

# install ingress 
sh scripts/ingress/install-ingress.sh
```



To uninstall use the command `sh scripts/k3s/uninstall-k3s-server.sh`

### Setup Worker Node

On the machine which you want to setup as worker node
```
export K3S_TOKEN=<token-here>
export K3S_URL=https://ip-address:6443
sh scripts/install-worker-node.sh
```

### Setup local and remote DNS 

```
```

ex: to access a deployment as r2lab.dev and r2lab.local 

### Deploy Application


#### Create Persistent Volume Claim

```
tee -a hello-world-pvc.yaml << END
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: hello-world-pvc-1
  namespace: default
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: local-path
  resources:
    requests:
      storage: 2Gi
END

kubectl apply -f hello-world-pvc.yaml

# kubectl edit pvc/hello-world-vol
```

```
tee -a hello-world-pv.yaml << END
kind: PersistentVolume
apiVersion: v1
metadata:
  name: hello-world-vol-2
  labels:
    type: local
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
END
kubectl apply -f hello-world-pv.yaml

kubectl get pv
```


Access modes can be : ReadWriteOnce, ReadOnlyMany, ReadWriteMany

#### Create Deployment
```
tee -a hello-world-deployment.yaml << END
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-world
spec:
  replicas: 1
  selector:
    matchLabels:
      app: hello-world
  strategy:
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: hello-world
    spec:
      containers:
        - name: homer-dashboard
          image:  b4bz/homer
          imagePullPolicy: IfNotPresent
          ports:
            - containerPort: 8080
              protocol: TCP
END

kubectl apply -f hello-world-deployment.yaml
kubectl get deployments/hello-world
kubectl rollout status deployments/hello-world
# kubectl delete deployments/hello-world

```



```
tee -a hello-world-service.yaml << END
apiVersion: v1
kind: Service
metadata:
  name: hello-world
spec:
  ports:
    - port: 80
      targetPort: 8300
      protocol: TCP
  selector:
    app:  hello-world
END

kubectl apply -f hello-world-service.yaml
```

```
tee -a hello-world-ingress.yaml << END
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: hello-world
  annotations:
    kubernetes.io/ingress.class: "traefik"
spec:
  rules:
  - host: hl.r2lab.dev
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: hello-world
            port:
              number: 80
END

kubectl apply -f hello-world-ingress.yaml
```


#### Creating ConfigMap

```
kubectl create configmap config4 --from-literal=foo_env=bar --from-literal=hello_env=world

or 

kubectl create configmap config5 --from-file=./config/app-config.properties
```

### Exposing deployment via local and remote DNS (with SSL)

```
```

## Stop, Scale and start deployments

```
```


https://kubernetes.io/docs/tasks/


https://www.jeffgeerling.com/blog/2022/quick-hello-world-http-deployment-testing-k3s-and-traefik

https://blog.thenets.org/how-to-create-a-k3s-cluster-with-nginx-ingress-controller/

https://qdnqn.com/how-to-configure-traefik-on-k3s/ 

https://k3s.rocks 

https://itnext.io/learn-how-to-configure-your-kubernetes-apps-using-the-configmap-object-d8f30f99abeb 


https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/

https://uthark.github.io/post/2021-10-06-running-pihole-kubernetes/

1. [Installations](docs/installations.md)
1. [Setup PI](docs/setup-pi.md)
2. [Setup Megamind](docs/setup-megamind.md)

## Infrastructure




DNS	Pi-hole + unbound 
VPN	Wireguard + Netmaker
Remote SSH Access	Teleport
Infrastructure Monitoring	Prometheus + Graphana
Homelab dashboard	
Reverse Proxy	Traefik
 CI/CD	Gocd ?


1. VPN - Netmaker + Wireguard
2. Remote SSH Access - Teleport
3. Monitoring & Alerts - Graphana and prometheus.

1. Could storage - NextCloud 
2. NAS - 
1. cloud storage + NAS - for files, photos and videos storage.


## 

 
## Personal Services
1. Nexcloud

## Demo Services
1. Invana Studio
2. Invana Engine 
3. JanusGraph

## Other Services 
1. Boring tunnel(proxy)
2. Reverse Proxy
3. 2FA
4. VPN
5. Teleport
6. CI/CD


## Infrastructure(k3s+Rancher)

### Installation
```
export HOST_DNS=infra.localhost.local
./INSTALL.sh
```

Use `kubectl -n cattle-system rollout status deploy/rancher` to verify the installation. 
Open the following ports. 
```
sudo ufw allow 443
sudo ufw allow 6443
```

Point `https://127.0.0.1:443` to your DNS entry.

### Connecting to Infrastructure from command-line

This required [Kubectl](https://kubernetes.io/docs/tasks/tools/).
To checking if installation successfull
```
echo "Checking Rancher installation if successfull"
kubectl get pods --all-namespaces
```

Refer https://ranchermanager.docs.rancher.com/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/back-up-docker-installed-rancher for more on backup and restore


### Setup Services using Terraform

```
terraform init
terraform apply
```

https://ranchermanager.docs.rancher.com/getting-started/quick-start-guides/deploy-workloads/workload-ingress
