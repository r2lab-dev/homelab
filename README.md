# Homelab

This repository contains code and documentation to setup homelab with [Rancher](https://github.com/rancher/rancher) - a complete container management platform

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


## Infrastructure(Rancher)

### Installation
```
export RANCHER_MOUNT_PATH=/mnt/<rancher-path>
./INSTALL.sh
```

### Connecting to Infrastructure from command-line

This required [Kubectl](https://kubernetes.io/docs/tasks/tools/). 
To checking if installation successfull
```
echo "Checking Rancher installation if successfull"
kubectl get pods --all-namespaces
```

Refer https://ranchermanager.docs.rancher.com/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/back-up-docker-installed-rancher for more on backup and restore