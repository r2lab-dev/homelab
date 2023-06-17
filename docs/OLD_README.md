## Terraform installation

```
sudo apt install -y gnupg software-properties-common curl
# Add Hashicorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
# Add Hashicorp repository to Ubuntu 22.04
 echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update 
sudo apt install terraform -y
terraform -install-autocomplete
```

## installing k3s for kubernetes

Default location of the config will be `/etc/rancher/k3s/k3s.yaml`.


### Install K3s
```
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s -
```

### Setup ~/.kube/config
Set `~/.kube/config` for terraform
```
mkdir -p $HOME/.kube
rm ~/.kube/config
#sudo cp -i /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
#sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl config view --raw > ~/.kube/config
```

### k3s without sudo 
```
export KUBECONFIG="~/.kube/config"
k3s kubectl get namespace
k3s kubectl get pods
```

### Test installation
```
sudo ls
kubectl get namespace
```

## Kubernetes dashboard

```
sudo ufw allow 8001 # allow by port
k3s kubectl proxy --address='0.0.0.0' --port=8001 --accept-hosts='.*'
```

## Kubernetes version
```
kubectl version --short
```

## Installing helmhelm ls -a

```
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```


```
sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw app list
sudo ufw allow ssh # allow by service name
sudo ufw allow 22 # allow by port

```



If ingress stuck
```
kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission

```