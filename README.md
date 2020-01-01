About this Repo
This is repo about doing CICD by deploy in k8s by jenkins
we using nginx as service to deploy
Steps:-
install jenkins on server and kubectl
first we install docker 
add normal user to docker group
install jenkins and needed plugins
add config file "k8s admin" to jenkins home folder
change owner to jenkins
......
##Kubernetes Installation
##Install Docker on both the nodes
sudo apt install docker.io
##Enable Docker on both the nodes
Add the Kubernetes signing key on both the nodes
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
## Install Kubeadm
 apt install kubeadm
## Disable swap memory
swapoff -a
Give Unique hostnames on both nodes
##Initialize Kubernetes on the master node
sudo kubeadm init --api-advertise-address=192.168.56.108 --pod-network-cidr=192.168.0.0/16
##Switch user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
##NOde Run
kubeadm join 192.168.56.108:6443 --token 06tl4c.oqn35jzecidg0r0m --discovery-token-ca-cert-hash sha256:c40f5fa0aba6ba311efcdb0e8cb637ae0eb8ce27b7a03d47be6d966142f2204c
####jenkins process#######



