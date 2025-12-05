terraform {
  backend "s3" {
    bucket = "terraform-demo-2025"
    key    = "vault-secrets/state"
    region = "us-east-1"
  }
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

# resource "vault_mount" "rabbitmq_credentails" {
#   path = "rabbitmq_credentails"
#   type = "kv"
#   options = { version = "2" }
#   description = "rabbitmq credentials"
# }

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

  data_json = <<EOF
{
  "REDIS_HOST": "redis-dev.devopsbymanju.shop"
  "CATALOGUE_HOST": "catalogue-dev.devopsbymanju.shop"
  "CATALOGUE_PORT": "8080"
}
EOF
}
#
# resource "vault_generic_secret" "roboshop_secrets" {
#   path = "${vault_mount.roboshop-dev.path}/catalogue"
#
#   data_json = <<EOT
# {
#   "MONGO_URL": "mongodb://mongodb-dev.devopsbymanju.shop:27017/catalogue"
# }
# EOT
# }
#
# resource "vault_generic_secret" "roboshop_secrets" {
#   path = "${vault_mount.roboshop-dev.path}/dispatch"
#
#   data_json = <<EOT
# {
#   "AMQP_HOST": "rabbitmq-dev.devopsbymanju.shop"
# }
# EOT
# }

# resource "vault_generic_secret" "rabbitmq_credentials" {
#   path = "${vault_mount.rabbitmq_credentails.path}/rabbitmq_credentails"
#   data_json = <<EOF
# {
# "AMQP_USER": roboshop
# "AMQP_PASS": roboshop123
# }
# EOF
# }