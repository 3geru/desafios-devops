resource "aws_vpc" "vpc_docker" {
  cidr_block           = "10.255.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
}

resource "aws_internet_gateway" "gw_docker" {
  vpc_id = "${aws_vpc.vpc_docker.id}"
}

resource "aws_route" "route_gw_docker" {
  route_table_id         = "${aws_vpc.vpc_docker.default_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw_docker.id}"
}

resource "aws_security_group" "sg_docker" {
  name        = "sg_docker"
  description = "Allow traffic to docker containers"
  vpc_id      = "${aws_vpc.vpc_docker.id}"

  ingress {
    from_port   = 0
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.allow_ips_ssh}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "sn_docker" {
  vpc_id     = "${aws_vpc.vpc_docker.id}"
  cidr_block = "10.255.0.0/24"
}
