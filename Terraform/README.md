
**Project Infrastructure**
=========================

This repository contains the Terraform configuration for the project infrastructure. The infrastructure consists of:

* A VPC with two subnets
* An EC2 instance for Jenkins
* An S3 bucket for storing project data
* An EKS cluster for running project workloads
* A secrets manager for storing sensitive data

**Terraform Configuration**
---------------------------

The Terraform configuration is organized into several files:

* `terraform.tf`: The main Terraform configuration file
* `variables.tf`: The file containing variable declarations
* `Jenkins.tf`: The file containing the EC2 instance configuration for Jenkins
* `s3.tf`: The file containing the S3 bucket configuration
* `eks.tf`: The file containing the EKS cluster configuration
* `secrets.tf`: The file containing the secrets manager configuration

**Usage**
-----

To use this Terraform configuration, follow these steps:

1. Clone this repository to your local machine
2. Install Terraform on your local machine
3. Run `terraform init` to initialize the Terraform configuration
4. Run `terraform apply` to apply the Terraform configuration
5. Run `terraform destroy` to destroy the infrastructure



**EKS Cluster Configuration**
---------------------------

The EKS cluster configuration is defined in `eks.tf`. The cluster is configured with:

* A node group with 2-3 instances of type `t3.micro`
* A subnet configuration that uses the `aws_subnet.project` resources
* A role configuration that uses the `aws_iam_role.eks_worker_role` resource
* A policy attachment configuration that uses the `aws_iam_role_policy_attachment` resources

**Contributing**
------------

Contributions are welcome! If you'd like to contribute to this project, please fork the repository and submit a pull request with your changes.


