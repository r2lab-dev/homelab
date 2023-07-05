# Setup machine


## setup ssh access 



### Create ssh key 
```
KEY_NAME='r2-user-key'

# create ssh key
ssh-keygen -t ed25519 -f ~/.ssh/$KEY_NAME

# add ssh key to your machine 
ssh-add  ~/.ssh/$KEY_NAME


```


```
REMOTE_USER='r2-user'
REMOTE_HOST=''

ssh-copy-id -i ~/.ssh/$KEY_NAME.pub $REMOTE_USER@$REMOTE_HOST
ssh $REMOTE_USER@$REMOTE_HOST
```



## setup raspberry-pi machines 

```
ansible -i inventory pi_nodes -m ping # make sure ssh access works
ansible-playbook main.yml -i inventory -t installation,services,pi
```



## setup debian machines



```
sudo apt -y update && sudo apt -y upgrade 
sudo apt-get install ansible -y
```

1. Run updates 
2. Create a new user `r2-user`
3. Add `r2-user` to sudoers 
4. Add ssh key 
5. Deploy k3s master 
6. Deploy k3s worker

