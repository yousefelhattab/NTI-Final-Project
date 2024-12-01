resource "aws_s3_bucket" "elb_logs" {
  bucket = "nti-elb-logs-bucket"
}


resource "aws_lb" "project_lb" {
  name               = "project-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.project.id]
  subnets            = [aws_subnet.project[0].id, aws_subnet.project[1].id]

  enable_deletion_protection = false
}
