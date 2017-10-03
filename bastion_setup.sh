#!/bin/bash
# setup docker-ce and awscli on Ubuntu Xenial 16.04 (LTS)
# https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-from-a-package
# http://docs.aws.amazon.com/cli/latest/userguide/installing.html

sudo apt-get remove -y docker docker-engine docker.io
sudo apt-get update -y

sudo apt-get install -y\
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update -y
sudo apt-get install -y docker-ce

sudo apt-get install -y python-setuptools
sudo easy_install pip
sudo pip install awscli
sudo pip install boto3
