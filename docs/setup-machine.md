# Setup machine


## setup ssh access 

```
REMOTE_USER=''
REMOTE_HOST=''
KEY_NAME='r2-user-key'

ssh-keygen -t ed25519 -f ~/.ssh/$KEY_NAME
ssh-copy-id -i ~/.ssh/$KEY_NAME.pub $REMOTE_USER@$REMOTE_HOST
ssh $REMOTE_USER@$REMOTE_HOST
```


## setup raspberry-pi machines 




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

