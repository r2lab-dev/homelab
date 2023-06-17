

export RANCHER_FQDN=rancher.r2lab.local

export RANCHER_VERSION_DEFAULT="v2.7.4"
export CERTMANAGER_VERSION_DEFAULT="v1.12.2"

[ -z "$RANCHER_FQDN" ] && echo "Exiting:: RANCHER_FQDN not set, cannot proceed. eg: RANCHER_FQDN=infra.localhost.local" && exit 1
[ -z "$RANCHER_VERSION" ] && RANCHER_VERSION=$RANCHER_VERSION_DEFAULT
[ -z "$CERTMANAGER_VERSION" ] && CERTMANAGER_VERSION=$CERTMANAGER_VERSION_DEFAULT


# install Rancher 
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
kubectl create namespace cattle-system
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/$CERTMANAGER_VERSION/cert-manager.crds.yaml
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version $CERTMANAGER_VERSION
helm install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set replicas=1 --set global.cattle.psp.enabled=false \
  --set tls=external \
  --version $RANCHER_VERSION \
  --set hostname=$RANCHER_FQDN
  
kubectl -n cattle-system rollout status deploy/rancher
echo "Rancher Installation Completeted :) [rancher: rancher-stable and cert-manager: $CERTMANAGER_VERSION ] "


# incase secrets "bootstrap-secret" not found run the below command to reset password
# kubectl -n cattle-system exec $(kubectl -n cattle-system get pods -l app=rancher | grep '1/1' | head -1 | awk '{ print $1 }') -- reset-password
