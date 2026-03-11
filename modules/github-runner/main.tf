resource "aws_instance" "tool" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = var.vpc_security_group_ids

  tags = {
    Name = var.tag_name
  }
}

resource "aws_route53_record" "records" {
  zone_id = var.zone_id
  name    = var.tag_name
  type    = "A"
  ttl     = 30
  records = [aws_instance.tool.private_ip]
}


# resource "aws_vpc_security_group_ingress_rule" "allow_app_port" {
#   security_group_id = var.vpc_security_group_ids
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = var.port
#   ip_protocol       = "tcp"
#   to_port           = var.port
#   description       = "${var.tag_name}_github_runner_port_dummy"
# }
