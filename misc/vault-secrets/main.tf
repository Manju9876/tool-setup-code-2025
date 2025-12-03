terraform {
  backend "s3" {
    bucket       = "terraform-demo-2025"
    key          = "vault-secrets/state"
    region       = "us-east-1"
  }
}

provider "vault" {
  address = "http://44.222.105.0:8200"
  token = var.vault_token
}

resource "vault_mount" "infra_access" {
  path        = "infra"
  type        = "kv"
  options     = { version = "2" }
  description = "roboshop dev secrets"
}


resource "vault_mount" "roboshop-dev" {
  path        = "roboshop-dev-secrets"
  type        = "kv"
  options     = { version = "2" }
  description = "roboshop dev secrets"
}

resource "vault_generic_secret" "infra_access" {
  path = "${vault_mount.infra_access.path}/ssh"

  data_json = <<EOT
{
  "username": "ec2-user",
  "password": "DevOps321"
}
EOT
}

resource "vault_generic_secret" "roboshop_secrets" {
  path = "${vault_mount.roboshop-dev.path}/cart"

  data_json = <<EOT
{
  "REDIS_HOST": "redis-dev.devopsbymanju.shop",
  "CATALOGUE_HOST": "catalogue-dev.devopsbymanju.shop",
  "CATALOGUE_PORT": "8080"
}
EOT
}

