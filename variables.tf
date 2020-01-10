variable "region" {
  type        = string
  default     = "us-east-1"
  description = "The AWS region where the CMK will be created"
}

variable "account_id" {
  type        = string
  description = "The AWS Account ID where the CMK will be created"
}

variable "aws_profile" {
  type        = string
  default     = "default"
  description = "The AWS CLI profile"
}

variable "heroku_account_id" {
  type        = string
  description = "The account id for the Heroku Data account to delegate access to the CMK"
}
