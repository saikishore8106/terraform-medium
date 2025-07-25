# ------------------------
# Provider Configuration
# ------------------------
provider "aws" {
  region = var.aws_region
}

# ------------------------
# EC2 Instances (Count = 4)
# ------------------------
resource "aws_instance" "example" {
  count         = 4
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "${var.instance_name}-${count.index + 1}"
  }
}

# ------------------------
# Variables
# ------------------------
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "instance_name" {
  description = "Base name for the EC2 instances"
  type        = string
  default     = "BasicEC2Instance"
}

# ------------------------
# Outputs
# ------------------------
output "instance_ids" {
  description = "IDs of the EC2 instances"
  value       = [for instance in aws_instance.example : instance.id]
}

output "public_ips" {
  description = "Public IPs of the EC2 instances"
  value       = [for instance in aws_instance.example : instance.public_ip]
}

