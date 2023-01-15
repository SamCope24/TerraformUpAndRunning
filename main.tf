provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami                    = "ami-0fb653ca2d3203ac1"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id] // links the EC2 instance to the security group

  // script that runs on startup and launches a websever
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello World!" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "terraform-example"
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
  type = number
  default = 8080
}

// output varaibles can be used to access values once resources have been created
output "public_ip" {
  value = aws_instance.example.public_ip
  description = "The public IP address of the web server"
}