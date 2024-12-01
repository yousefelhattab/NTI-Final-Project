provider "aws" {
  region = "us-east-1" # Replace with your preferred AWS region
}

resource "aws_ecr_repository" "project_repo" {
  name = "nti-repo"

  image_tag_mutability = "MUTABLE" # Optional, allows tags to be overwritten
  image_scanning_configuration {
    scan_on_push = true # Enable image scanning on push
  }
}

output "ecr_repository_url" {
  value = aws_ecr_repository.project_repo.repository_url
  description = "The URL of the ECR repository"
}
