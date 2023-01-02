# This script will install Rancher + K3s
# https://ranchermanager.docs.rancher.com/getting-started/quick-start-guides/deploy-rancher-manager/helm-cli
# https://docs.k3s.io/installation/kube-dashboard


export CONTAINER_NAME=rancher
export K3S_VERSION_DEFAULT="v1.24.9+k3s1"
#export RANCHER_PORT_PREFIX_DEFAULT=9
export RANCHER_VERSION_DEFAULT="v2.7"

[ -z "$HOST_DNS" ] && echo "Exiting:: HOST_DNS not set, cannot proceed. eg: HOST_DNS=infra.localhost.local" && exit 1
[ -z "$K3S_VERSION" ] && K3S_VERSION=$K3S_VERSION_DEFAULT
[ -z "$RANCHER_VERSION" ] && RANCHER_VERSION=$RANCHER_VERSION_DEFAULT

# install k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=$K3S_VERSION K3S_KUBECONFIG_MODE="644"  sh -s - server --cluster-init

echo "Copying k3s.yaml to $HOME/.kube/config"
cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
echo "Setting the permissions 644 to $HOME/.kube/config"
sudo chmod go-r $HOME/.kube/config

# install heml


# install Rancher 
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
kubectl create namespace cattle-system
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.7.1/cert-manager.crds.yaml
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.7.1
helm install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=$HOST_DNS \
  --set replicas=1

echo "k3s.yaml copied to $HOME/.kube/config"
 
sudo ufw allow 443
sudo ufw allow 6443

#Reference notes:
# If this is the first time you installed Rancher, get started by running this command and clicking the URL it generates:
# ```
# echo https://infra.localhost.local/dashboard/?setup=$(kubectl get secret --namespace cattle-system bootstrap-secret -o go-template='{{.data.bootstrapPassword|base64decode}}')
# ```
#
# To get just the bootstrap password on its own, run:
# ```
# kubectl get secret --namespace cattle-system bootstrap-secret -o go-template='{{.data.bootstrapPassword|base64decode}}{{ "\n" }}'#  
# ```
