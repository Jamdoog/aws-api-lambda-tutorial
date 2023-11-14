# AWS Region
variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "eu-west-2"
}

# AWS Zone A
variable "aws_zonea" {
  type        = string
  description = "AWS Zone"
  default     = "eu-west-2a"
}

# AWS Zone B
variable "aws_zoneb" {
  type        = string
  description = "AWS Zone"
  default     = "eu-west-2b"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  profile = "awsprofile"
  region = var.aws_region
}
