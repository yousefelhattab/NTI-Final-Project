variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
variable "environment" {
  description = "The environment for the cluster (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "my-cluster"
}

variable "private_subnets" {
  description = "List of private subnet IDs for the node group"
  type        = list(string)
  default     = []
}

resource "aws_iam_role" "backup_role" {
  name        = "backup-role"
  description = "Role for backup"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "backup.amazonaws.com"
        }
      }
    ]
  })
}
resource "aws_instance" "jenkins_instance" {
  ami           = "ami-005fc0f236362e99f"
  subnet_id     = aws_subnet.project[0].id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.project.id]
}
variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Name of the key pair"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/8"
}

variable "subnet_cidr_jenkins_server" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.0.0/9"
}
variable "backup_scheduler" {
  default = "cron(0 0 */5 * ? *)"
  description = "schedule of backup process"
  
}
variable "backup_life_cycle" {
  default = 15
  description = "delete after life N of days"
  
}

variable "elb_log_bucket" {
  default = "the_s3_bucket_of_elb_4321"
  description = "the name of ELB bucket"
}