#vim .bashrc
#export PATH=$PATH:/usr/local/bin/
#source .bashrc

**Launch an EC2 instance with Ubuntu and 20GB storage.**
   👉 Creates a virtual machine in AWS where Kubernetes tools will be installed.
**Attach IAM role to EC2 with AdministratorAccess.**
   👉 Gives EC2 permission to access AWS services like EC2, S3, IAM, and VPC without using access keys.
**ssh -i key.pem ubuntu@<EC2-IP>**
   👉 Connects your local system to the EC2 instance securely.
**vim ~/.bashrc**
   👉 Opens the shell configuration file to set environment variables.
**export PATH=$PATH:/usr/local/bin/**
   👉 Adds system path so installed tools (kubectl, aws, kops) can run from anywhere.
**source ~/.bashrc**
   👉 Applies the updated PATH settings immediately.
**curl "[https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip](https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip)" -o "awscliv2.zip"**
   👉 Downloads AWS CLI installation package.
**aws --version**
   👉 Verifies AWS CLI installation.
**curl -LO "[https://dl.k8s.io/release/$(curl](https://dl.k8s.io/release/$%28curl) -L -s [https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl](https://dl.k8s.io/release/stable.txt%29/bin/linux/amd64/kubectl)"**
   👉 Downloads kubectl (Kubernetes CLI tool).
**chmod +x kubectl**
    👉 Makes kubectl executable.
**mv kubectl /usr/local/bin/**
    👉 Moves kubectl to system path for global access.
**kubectl version --client**
    👉 Verifies kubectl installation.
**Create IAM User (Access Key Setup)**
    👉 Go to AWS Console → IAM → Users → Create User → Enable programmatic access.
**Create Access Key for IAM User**
    👉 In IAM → User → Security Credentials → Create Access Key → Select “Command Line Interface (CLI)”.

---------------------------------------------------------------------------------------------------------------------

#! /bin/bash
aws configure
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
wget https://github.com/kubernetes/kops/releases/download/v1.34.1/kops-linux-amd64
chmod +x kops-linux-amd64 kubectl
mv kubectl /usr/local/bin/kubectl
mv kops-linux-amd64 /usr/local/bin/kops

aws s3api create-bucket --bucket cloud-learning-lab.k8s.local --region us-east-1
aws s3api put-bucket-versioning --bucket cloud-learning-lab.k8s.local --region us-east-1 --versioning-configuration Status=Enabled
export KOPS_STATE_STORE=s3://cloud-learning-lab.k8s.local
kops create cluster --name eks-playground.k8s.local --zones us-east-1a --master-count=1 --master-size t2.large --node-count=2 --node-size t2.large
kops update cluster --name eks-playground.k8s.local --yes --admin



use "sh kops.sh" command to run the script
wait for 5 mins
now check the cluster is ready or not : kubectl get no
it will result 3 nodes in ready state


TO DELETE THE CLUSTER 
export KOPS_STATE_STORE=your-bucket-name
kops get cluster 
kops delete cluster cluster-name --yes
