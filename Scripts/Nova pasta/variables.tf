variable "region" {
  default = "us-east-1"
}

variable "CentosUser" {
  default = "centos"
  description = "The Centos AWS user "
}

variable "AmiLinux" {
  type = "map"
  default = {
    us-east-1 = "ami-7c280d1c" # North Virginia
  }
}

/*
variable "aws_access_key" {
  default = "xxxxx"
  description = "the user aws access key"
}
variable "aws_secret_key" {
  default = "xxxx"
  description = "the user aws secret key"
}
*/

variable "credentialsfile" {
  default = "/Users/samrogers/.aws/credentials" #replace your home directory
  description = "where your access and secret_key are stored, you create the file when you run the aws config"
}

variable "vpc-fullcidr" {
    default = "10.2.0.0/16"
  description = "the vpc cdir"
}

variable "Subnet-Public-AzA-CIDR" {
  default = "10.2.1.0/24"
  description = "the cidr of the subnet"
}

variable "Subnet-Private-AzA-CIDR" {
  default = "10.1.2.0/24"
  description = "the cidr of the subnet"
}

# This the local IP from my workstation (i.e. My home computer) so I can ssh into the AWS servers from 
# This is included in a .tfvars file that is not uploaded to Git.
variable "localip" {
   default = "73.41.159.141/32"
   description = "This the local IP from my workstation included in a .tfvars file "
}


variable "key_name" {
  default = "sams_tf_nodejs"
  description = "This is the key Pair name that you create in AWS to user to access AWS"
}

variable "public_key_path" {
  default = "~/.ssh/sams_tf_key.pub"
  description = "This ssh key that you created locally to use in the web EC2 machines"
}

# This the instances to create for load balancer. 
variable "number_of_instances" {
  description = "Number of instances to create and attach to ELB"
  default     = 3
}