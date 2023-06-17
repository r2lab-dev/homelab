# This script will install  K3s
# https://ranchermanager.docs.rancher.com/getting-started/quick-start-guides/deploy-rancher-manager/helm-cli
# https://docs.k3s.io/installation/kube-dashboard
#

export K3S_VERSION_DEFAULT="v1.25.10+k3s1" #"v1.24.9+k3s1" #v1.26.5+k3s1/sha256sum-arm64.txt

[ -z "$K3S_VERSION" ] && K3S_VERSION=$K3S_VERSION_DEFAULT
# [ -z "$K3S_URL" ] && echo "Exiting:: K3S_URL not set, cannot proceed. eg: K3S_URL=k3s.localhost.local" && exit 1

# install k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=$K3S_VERSION K3S_KUBECONFIG_MODE="644" \
  K3S_NODE_NAME=k3s-master-01  sh -s - server --cluster-init

# copying kube/config to the user
echo "Copying /etc/rancher/k3s/k3s.yaml to $HOME/.kube/config"
cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
# echo "Setting the permissions 644 to $HOME/.kube/config"
# sudo chmod go-r $HOME/.kube/config

# echo "Connect to k3s using K3S_URL is $K3S_URL" 


