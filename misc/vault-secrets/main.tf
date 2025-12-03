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
  "username": "ec2-user",
  "password": "DevOps321"
}
EOT
}

# resource "vault_mount" "" {
#   path        = "kvv2"
#   type        = "kv"
#   options     = { version = "2" }
#   description = "KV Version 2 secret engine mount"
# }
resource "vault_generic_secret" "roboshop_secrets" {
  path = "roboshop-dev-secrets/cart"

  data_json = <<EOT
{
  "username": "ec2-user",
  "password": "DevOps321"
}
EOT
}