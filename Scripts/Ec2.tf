provider "aws" {
  region     = "us-east-1"
}


resource "aws_instance" "instancia" {
  ami           = "ami-00068cd7555f543d5"
  instance_type = "t2.micro"
  key_name = "demo"
  security_groups = ["wz-1"]
}

resource "aws_instance" "instancia2" {
  ami           = "ami-00068cd7555f543d5"
  instance_type = "t2.micro"
  key_name = "demo"
  security_groups = ["wz-1"]
}


resource "aws_instance" "instancia3" {
  ami           = "ami-00068cd7555f543d5"
  instance_type = "t2.micro"
  key_name = "demo"
  security_groups = ["wz-1"]
}

