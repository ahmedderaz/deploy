# CICD using jenkins and kubernetes




[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

# Install and Deploy Kubernetes on Ubuntu 18.04 LTS

  - prepare five hosts for project 
  -use four servers for kubernetes (one as master other worker nodes) and one for jenkins and sonarqube

Install the dependencies and prerequisite in all servers.
Docker installation...
```sh
$ sudo apt install docker.io
$ sudo systemctl enable docker
$ sudo usermoad -aG docker $username
```

For kubernetes installation ...

```sh
$ sudo swapoff -a
$ curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
$ sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
$ sudo apt install kubeadm -y
$ sudo hostnamectl set-hostname $node-name
```

### Initialize Kubernetes on the master node
```sh
$ kubeadm init --api-advertise-address=$ip-address --pod-network-cidr=10.244.0.0/16
$ mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

### Join nodes to master
run this in all worker nodes like that using root user
```sh
$ kubeadm join $ip_addess:6443 --token 06tl4c.oqn35jzecidg0r0m --discovery-token-ca-cert-hash sha256:c40f5fa0aba6ba311efcdb0e8cb637ae0eb8ce27b7a03d47be6d966142f2204c
```

### Deploy a Pod Network through the master node
```sh
$ sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
$ kubectl get nodes   
$ kubectl get pods --all-namespaces
```





