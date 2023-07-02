# Homelab

This repository contains infrastructure code and documentation to setup my homelab 
## The Purpose

This homelab should serve the following purposes. 

1. [Hosting personal-services](#personal-services)
2. [Hosting demo-services](#demo-services)
3. [Hosting other-services](#other-services)
 
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
