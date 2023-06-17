 # https://pet2cattle.com/2021/04/k3s-join-nodes



export K3S_VERSION_DEFAULT="v1.25.10+k3s1" #"v1.24.9+k3s1" #v1.26.5+k3s1/sha256sum-arm64.txt
[ -z "$K3S_URL" ] && echo "Exiting:: K3S_URL not set, cannot proceed." && exit 1
[ -z "$K3S_TOKEN" ] && echo "Exiting:: K3S_TOKEN not set, cannot proceed.
 Run `sudo cat /var/lib/rancher/k3s/server/node-token` on master node to get the token" && exit 1
[ -z "$K3S_VERSION" ] && K3S_VERSION=$K3S_VERSION_DEFAULT


curl -sfL https://get.k3s.io | K3S_URL=$K3S_URL K3S_TOKEN=$K3S_TOKEN INSTALL_K3S_VERSION=$K3S_VERSION K3S_KUBECONFIG_MODE="644" \
  K3S_NODE_NAME=k3s-worker-01  sh -

sudo systemctl enable --now k3s-agent