# This script will install Rancher + K3s
# https://ranchermanager.docs.rancher.com/pages-for-subheaders/install-upgrade-on-a-kubernetes-cluster


export CONTAINER_NAME=rancher
export RANCHER_PORT_PREFIX_DEFAULT=9
export RANCHER_VERSION_DEFAULT=latest
#[ -z "$PORT_PREFIX" ] && echo "Exiting:: PORT_PREFIX not set, cannot proceed." && return
[ -z "$RANCHER_VERSION" ] && RANCHER_VERSION=$RANCHER_VERSION_DEFAULT
[ -z "$RANCHER_PORT_PREFIX" ] && RANCHER_PORT_PREFIX=$RANCHER_PORT_PREFIX_DEFAULT
#[ -z "$RANCHER_MOUNT_PATH" ] && echo "Exiting:: RANCHER_MOUNT_PATH not set, cannot proceed." && exit 1


# start Rancher with docker container
docker run -d --name $CONTAINER_NAME \
  --restart=unless-stopped \
  -p ${RANCHER_PORT_PREFIX}80:80 -p ${RANCHER_PORT_PREFIX}443:443 -p 6443:6443 \
  --privileged \
  rancher/rancher:$RANCHER_VERSION

# get the password of the Rancher admin
echo ''

# while ! docker logs container | grep -q "[services.d] done.";
# do
#     sleep 1
#     echo "working..."
# done

until docker logs $CONTAINER_NAME  2>&1 | grep -q "Bootstrap Password:";
do
  sleep 1
  echo "Server starting.. Waiting 1 more second..."
done
echo "here is the password to login"
echo `docker logs $CONTAINER_NAME  2>&1 | grep "Bootstrap Password:"`
echo ''

# copy kube/config to host machines.
docker cp $CONTAINER_NAME:/etc/rancher/k3s/k3s.yaml $HOME/.kube/config
# correct the permissions for kube/config
echo "k3s.yaml copied to $HOME/.kube/config"
echo "Setting the permissions 644 to $HOME/.kube/config"
chmod 644  $HOME/.kube/config


 
#sudo ufw default deny incoming
#sudo ufw default allow outgoing

#sudo ufw app list
sudo ufw allow ${RANCHER_PORT_PREFIX}443
sudo ufw allow 6443

#sudo ufw allow 8001 # allow by port
#kubectl proxy --address='0.0.0.0' --port=8001 --accept-hosts='.*'


