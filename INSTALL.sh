# This script will install Rancher + K3s
# https://ranchermanager.docs.rancher.com/pages-for-subheaders/install-upgrade-on-a-kubernetes-cluster
#
#

CONTAINER_NAME=rancher
#[ -z "$PORT_PREFIX" ] && echo "Exiting:: PORT_PREFIX not set, cannot proceed." && return
[ -z "$RANCHER_VERSION" ] && RANCHER_VERSION=latest
[ -z "$RANCHER_MOUNT_PATH" ] && echo "Exiting:: RANCHER_MOUNT_PATH not set, cannot proceed." && exit 1


# start Rancher with docker container
docker run -d --name $CONTAINER_NAME \
  --restart=unless-stopped \
  -p 80:80 -p 443:443 -p 6443:6443 \
  --privileged \
  rancher/rancher:$RANCHER_VERSION

# get the password of the Rancher admin
echo ''
echo "here is the first time password "
echo `docker logs $CONTAINER_NAME  2>&1 | grep "Bootstrap Password:"`
echo ''

# copy kube/config to host machines.
docker cp $CONTAINER_NAME:/etc/rancher/k3s/k3s.yaml $HOME/.kube/config
# correct the permissions for kube/config
sudo chmod 644  $HOME/.kube/config
echo "k3s.yaml copied to $HOME/.kube/config."


 
#sudo ufw default deny incoming
#sudo ufw default allow outgoing

#sudo ufw app list
#sudo ufw allow 443

#sudo ufw allow 8001 # allow by port
k3s kubectl proxy --address='0.0.0.0' --port=8001 --accept-hosts='.*'


