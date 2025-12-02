terraform {
  backend "s3" {
    bucket       = "terraform-demo-2025"
    key          = "vault-secrets/state"
    region       = "us-east-1"
  }
}

provider "vault" {
  address = "http://vault.devopsbymanju.shop:8200"
  token = var.vault_token
}
variable "vault_token" {}

resource "vault_generic_secret" "example" {
  path = "infra/ssh"

  data_json = <<EOT
{
  "username":   "ec2-user",
  "password": "DevOps321"
}
EOT
}