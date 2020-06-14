####   Install Kubernetes


setenforce 0
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux

echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables

swapoff -a

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

yum install -y kubeadm* docker*

systemctl start kubelet && systemctl enable kubelet
systemctl start docker && systemctl enable docker

##Check kubernetes Service
kubelet_status=`systemctl status kubelet | grep "running" | wc -l`
echo "$kubelet_status"
if [ $kubelet_status == 1 ]; then
   echo "Kubelet installed and running .."
else
   echo "Kubelet installed but not running.."

##Check Docker Service
docker_status=`systemctl status docker | grep "running" | wc -l
echo "$docker_status"
if [ $docker_status == 1 ]; then
    echo "Docker installed and running .."
else
echo "Docker installed but not running.."

fi
