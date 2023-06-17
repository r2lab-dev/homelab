# Setup Pi


## Setup SSH Access for Pi 

```
# create ssh key
ssh-keygen -t ed25519 -C "youremail@example.com" -f ~/.ssh/pi_ed25519

# add this ssh key to Mac 
ssh-add --apple-use-keychain ~/.ssh/pi_ed25519

# add this ssh key to Pi
ssh-copy-id -i ~/.ssh/pi_ed25519 user@pi-address
```

Connect to Pi using 
```
ssh pi@pi-address -i ~/.ssh/pi_ed25519
```

## Install k3s


Add `cgroup_memory=1 cgroup_enable=memory` to `/boot/cmdline.txt`

```
scp scripts/k3s/install-k3s.sh pi@pi-address:~/
ssh pi@pi-address "chmod +x ~/install-k3s.sh && export HOST_DNS=antman.infra.local && sh ~/install-k3s.sh"
```

https://developer.hashicorp.com/terraform/tutorials/docker-get-started/docker-build


## Create Backups of volumes

Assuming all the volumes are in `~/storage/` folder
```
export backup_filename="storage-$(date +%Y-%m-%d-%H%M%S).tar.gz"
sudo tar -czvf $backup_filename  ~/storage/
scp $backup_filename ravi-merugu@192.168.0.40:~/pi-backups/
```
