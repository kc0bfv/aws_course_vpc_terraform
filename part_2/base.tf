terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.21"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

variable "env_tag" {
  default = "aws_course_vpc"
}

variable "private_count" {
  default = 2
}
