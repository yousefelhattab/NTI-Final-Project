# Project Infrastructure

This repository contains the Terraform configuration for the project infrastructure.

## Overview

The project infrastructure consists of:

* A VPC with two subnets
* An EC2 instance for Jenkins
* An S3 bucket for storing project data
* An EKS cluster for running project workloads
* A secrets manager for storing sensitive data

## Terraform Configuration

The Terraform configuration is organized into several files:

* `terraform.tf`: The main Terraform configuration file
* `variables.tf`: The file containing variable declarations
* `Jenkins.tf`: The file containing the EC2 instance configuration for Jenkins
* `s3.tf`: The file containing the S3 bucket configuration
* `eks.tf`: The file containing the EKS cluster configuration
* `secrets.tf`: The file containing the secrets manager configuration

## Usage

To use this Terraform configuration, follow these steps:

1. Clone this repository to your local machine
2. Install Terraform on your local machine
3. Run `terraform init` to initialize the Terraform configuration
4. Run `terraform apply` to apply the Terraform configuration
5. Run `terraform destroy` to destroy the infrastructure

## Notes

* Make sure to update the `variables.tf` file with your own values for the variables
* Make sure to update the `Jenkins.tf` file with your own values for the EC2 instance configuration
* Make sure to update the `s3.tf` file with your own values for the S3 bucket configuration
* Make sure to update the `eks.tf` file with your own values for the EKS cluster configuration
* Make sure to update the `secrets.tf` file with your own values for the secrets manager configuration