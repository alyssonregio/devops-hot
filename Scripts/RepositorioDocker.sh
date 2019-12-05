#!/usr/bin/bash

#run this script on all hosts if docker is not available in default repos 
#1. Set up the repository

#Set up the Docker CE repository on CentOS:

sudo yum install -y yum-utils

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum makecache fast