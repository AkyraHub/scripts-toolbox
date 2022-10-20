#!/usr/bin/env bash

SERVER_IP=$1
SERVER_DNS=$2

echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQChuWx2NbYtGv9P12Be/3u2PozQ7Dp1mLb9tb4y3bOZy/uSSuFKvErqqo1H2O9ktGNQuxYWZYBjbaVRG6ruo8n2uA3PTR4j52BetAwwyw7ZIK7lUg6BhJblA283S0haQsj1DwVIL2eLQAdMNsO8mO+bBBhs5bbYZVLIKkON0HVkK7+XCkko5Uh7Qx4dL4H4Tz1CVE+ShRW1eqJcS+ZOL3EX3iTUEcPQ5VL+fQWesr/+eLDn/c34luqnLuX/jPLEaVfp3Xb9dZsjpQoN38B0WNCTfLTArykLljrTvXEvmnTH6EHjhy+by1NOlQGvcQT58XPY950wKI1DEtzAuOXkmLBD tristandeoliveira@MacBook-Pro-de-Tristan.local" >> /home/ubuntu/.ssh/authorized_keys
sudo snap install microk8s --classic --channel=1.24
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube
sudo su - $USER
microk8s status --wait-ready
microk8s enable dns storage

sudo sed -i "/^IP\.2 = .*/a IP\.3 = $SERVER_IP" /var/snap/microk8s/current/certs/csr.conf.template
sudo sed -i "/^DNS\.5 = .*/a DNS\.6 = $SERVER_DNS" /var/snap/microk8s/current/certs/csr.conf.template

sudo microk8s refresh-certs -e server.crt
sudo microk8s refresh-certs -e ca.crt
sudo microk8s refresh-certs -e front-proxy-client.crt

microk8s status --wait-ready
microk8s config | sed "s/server: .*/server: https:\/\/$SERVER_DNS:16443/g"
