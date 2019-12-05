#!/usr/bin/bash

echo "installing ansible"

sudo rpm -iUvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

sudo yum -y update

sudo yum -y install ansible

ansible --version
