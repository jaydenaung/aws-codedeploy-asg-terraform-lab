variable "project_name" {
  description = "Project Name - will prefex all generated AWS resource names"
  default     = "devops-sg"
}

######################################
######## Account Settings ############
######################################

provider "aws" {
  #  shared_credentials_file = "~/.aws/credentials"
  #  shared_credentials_file = "%USERPROFILE%\.aws\credentials"
  /*
      Shared credential files is a text file with the following format:
        [<PROFILE>]
        aws_access_key_id = <ACCESS_KEY_ID>
        aws_secret_access_key = <SECRET_ACCESS_KEY
  */
  profile = "default"
  region  = var.region
  version = "~> 2.61.0"
}


variable "region" {
  default = "ap-southeast-1"
}

data "aws_availability_zones" "azs" {
}

variable "devops_sg_cidr_vpc" {}
variable "key_name" {}
variable "AmazonEC2FullAccess_arn" {}
variable "AmazonS3FullAccess_arn" {}
variable "AWSCodedeploy_arn" {}
variable "AmazonS3ReadOnlyAccess_arn" {}
variable "sydney_master_key_arn" {}
variable "aws_linux_ami_sg" {}
variable "ssl_cert_arn" {}
variable "ubuntu_18_sg" {}
variable "ubuntu_20_sg" {}
variable "r53zone" {}
variable "externaldnshost" {}