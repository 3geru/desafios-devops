data "aws_ami" "apache" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-2018.03.0.20180811-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Joao Oliveira
}


resource "aws_network_interface" "general_docker" {
  subnet_id = "${aws_subnet.sn_docker.id}"
  security_groups = ["${aws_security_group.sg_docker.id}"]
}

resource "aws_security_group_rule" "allow_http" {
  type            = "ingress"
  from_port       = 0
  to_port         = 80
  protocol        = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.sg_docker.id}"
}

module "apache_instance" {
  source        = "./modules/instances"
  version       = "0.0.1"
  
  # Definicoes
  instance_type               = "t2.micro"
  associate_public_ip_address = "true"
  user_data_base64            = "IyEvYmluL2Jhc2gKCnl1bSBpbnN0YWxsIC15IGRvY2tlcgoKY2hrY29uZmlnIC0tYWRkIGRvY2tlcgoKc2VydmljZSBkb2NrZXIgc3RhcnQgCgpkb2NrZXIgcnVuIC1kIC1wIDgwOjgwIC0tcmVzdGFydCBhbHdheXMgaHR0cGQK"
  
  # Variaveis
  key_name               = "${aws_key_pair.devops_teste.key_name}"
  ami                    = "${data.aws_ami.apache.id}"
  subnet_id              = "${aws_subnet.sn_docker.id}"
  vpc_security_group_ids = ["${aws_security_group.sg_docker.id}"]
}

output "public_address" {
  value = "${module.apache_instance.address}"
}
