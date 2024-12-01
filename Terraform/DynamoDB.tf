resource "aws_dynamodb_table" "app_table" {
  name         = "${var.environment}-app-table"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "id"
    type = "S"
  }

  hash_key = "id"

  tags = {
    Environment = var.environment
    Project     = "NTI"
  }
}
