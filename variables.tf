variable "project_name" {
  default     = "jayden-devops"
}

provider "aws" {
  profile = "default"
  region  = var.region
  version = "~> 2.61.0"
}

variable "region" {
  default = "ap-southeast-2"
}

data "aws_availability_zones" "azs" {
}

#VPC CIDR
#Update this with your desired CIDR range
variable "devops_cidr_vpc" {
  description = "Jayden Devops CodeDeploy Demo VPC CIDR"
  default     = "10.40.0.0/16"
}

variable "key_name" {}
variable "AmazonEC2FullAccess_arn" {}
variable "AWSCodedeploy_arn" {}
variable "AmazonS3FullAccess_arn" {}
variable "ubuntu_18_sydney" {}
variable "r53zone" {}
variable "externaldnshost" {}




