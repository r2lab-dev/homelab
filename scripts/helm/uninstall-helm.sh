

helm ls -a --all-namespaces | awk 'NR > 1 { print  "-n "$2, $1}' | xargs -L1 helm delete 
sudo rm /usr/local/bin/helm
rm -Rf $HOME/.config/helm
rm -Rf $HOME/.cache/helm
rm -Rf $HOME/.local/share/helm
