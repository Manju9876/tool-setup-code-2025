variable "ami_id" {
  default = "ami-09c813fb71547fc4f"
}

variable "tools" {
  default = {
    vault={
      instance_type = "t3.small"
      port = 8200
      zone_id = "Z02811011NU5NZAZHXN3J"
    }
  }
}
