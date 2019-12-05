######
# ELB
######  

# Our elb security group to access
# the ELB over HTTP
resource "aws_security_group" "TF_elb_sg" {
  name        = "TF_elb_sg"
  description = "ELB security group to access the ELB over HTTP"

  vpc_id = "${aws_vpc.terraformmain.id}"

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # HTTP access from anywhere
  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ensure the VPC has an Internet gateway or this step will fail
  depends_on = ["aws_internet_gateway.gw", "aws_instance.nginx_nodejs"]
}

resource "aws_elb" "TF_ELB_web" {
  name = "TF-ELB-web"

  # The same availability zone as our instance
  subnets = ["${aws_subnet.TFPublicAZA.id}"]
  instances       = ["instancia.i-0be39a1faeddd5aa5", "instancia1.i-044e71d2167402f14","instancia2.i-d690356624dsf31]
  security_groups = ["${aws_security_group.TF_elb_sg.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 8080
    lb_protocol       = "http"
  }
	
  listener {
    instance_port     = 8081
    instance_protocol = "http"
    lb_port           = 8081
    lb_protocol       = "http"
  }
  	
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
}
