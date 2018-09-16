output "address" {
  value = "${aws_instance.instance.public_dns}"
}

