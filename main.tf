provider "aws" {
  region = "us-east-2"
}

// acts as a datasource for the default aws vpc
data "aws_vpc" "default" {
  default = true
}

// used to pull subnet data from the default vpc
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_launch_configuration" "example" {
  image_id        = "ami-0fb653ca2d3203ac1"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.instance.id] // links the EC2 instance to the security group

  // script that runs on startup and launches a websever
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello World!" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  // Required when using a launch configuration with an auto scaling group 
  lifecycle {
    create_before_destroy = true
  }
}

// creation of an auto scaling group that runs between 2 and 10 EC2 instances
resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name
  vpc_zone_identifier  = data.aws_subnets.default.ids

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}

// aws securtiy group to allow incoming requests on port 8080 from any IP
resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    description      = "Example Security Group"
    from_port        = var.server_port
    to_port          = var.server_port
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

// variable for sotring the port number in a single place
variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}