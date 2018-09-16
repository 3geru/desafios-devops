terraform {
  backend "s3" {
    bucket = "terraform.devops-testes.idwall"
    key = "idwall"
    region = "us-east-1"
  }
  lifecycle = {
    prevent_destroy = "true"
  }
}
