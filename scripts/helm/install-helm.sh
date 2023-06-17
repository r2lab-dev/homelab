# install helm

echo "Installing helm charts"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm ./get_helm.sh


# delete any existing helm
# echo "Deleting existing helm charts"
# helm ls -a --all-namespaces | awk 'NR > 1 { print  "-n "$2, $1}' | xargs -L1 helm delete 
helm ls -a --all-namespaces

echo "helm installation done :) "
