# rrmerugu/homelab

This repository contains code and documentation of my homelab - a private compute and storage infrastructure.


## install 


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
