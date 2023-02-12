provider "aws" {
  region = "us-east-2"
}

module "webserver_cluster" {
  source = "../../../../modules/services/webserver-cluster"

  ami = "ami-0fb653ca2d3203ac1"
  server_text = "Think Positive!"

  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "terraform-up-and-running-state-5829cbe9"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 3
  enable_autoscaling = false
}

# as not using inline ingress/egress we can add new rules for the staging
# env to expose additional ports for testing purposes

resource "aws_security_group_rule" "allow_testing_inbound" {
  type = "ingress"
  security_group_id = module.webserver_cluster.alb_security_group_id

  from_port = 12345
  to_port = 12345
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}