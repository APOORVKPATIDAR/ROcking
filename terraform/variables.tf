variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
  default = "ami-0c7217cdde317cfec"  # Amazon Linux 2 AMI (verify latest for your region)
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "Name of your EC2 key pair"
  type        = string
}
