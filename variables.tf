variable "ami_id" {
  default = "ami-09c813fb71547fc4f"
}

variable "tools" {
  default = {
    vault={
      instance_type = "t3.small"
      port = 8200
      zone_id = "Z02172973H3VL07HN6IMU"
    }
  }
}
