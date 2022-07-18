#!/usr/bin/env bash

# For slides
sudo yum install -y figlet
sudo yum install -y ncurses

# To support Termgraph
# Install python3 and pip3
sudo yum install -y python3-pip
python3 -m pip install termgraph

# Install OCI CLI and terraform
sudo dnf -y install oraclelinux-developer-release-el8
sudo dnf install python36-oci-cli
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform
echo "Please validate and configure your OCI CLI tools "
echo "RUN: oci --version"
echo "RUN: oci setup config"
