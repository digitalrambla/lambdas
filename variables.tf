variable "region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "us-west-2"
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository. Easier to create this manually to avoid chicken and egg scenario"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

variable "env" {
  description = "Environment e.g. dev, sys, prd"
  type        = string
  default     = "dev"
}

variable "prefix" {
  description = "Prefix all the resources with a project identifier"
  type        = string
  default     = "tmp"
}