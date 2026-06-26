variable "aws_region" {
  description = "AWS region for the infrastructure"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for tagging resources"
  type        = string
  default     = "cloud-infrastructure-deployment-lab"
}