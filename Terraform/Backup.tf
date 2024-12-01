resource "aws_backup_vault" "jenkins_vault" {
  name = "jenkins-backup-vault"
}

resource "aws_backup_plan" "jenkins_backup_plan" {
  name = "jenkins-backup-plan"
  
  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.jenkins_vault.name
    schedule          = "cron(0 12 * * ? *)"  # Daily backup
    lifecycle {
      delete_after = 30
    }
  }
}



resource "aws_iam_policy" "backup_policy" {
  name        = "backup-policy"
  description = "Policy for backup"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowGetResources"
        Effect    = "Allow"
        Action    = "tag:GetResources"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "backup_policy_attachment" {
  role       = aws_iam_role.backup_role.name
  policy_arn = aws_iam_policy.backup_policy.arn
}
resource "aws_backup_selection" "jenkins_backup_selection" {
  name         = "jenkins-backup-selection"
  plan_id      = aws_backup_plan.jenkins_backup_plan.id
  iam_role_arn = aws_iam_role.backup_role.arn

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup"
    value = "true"
  }
}
resource "aws_iam_role_policy_attachment" "eks_node_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role" "eks_node_role" {
  name        = "eks-worker-role"
  description = "Role for EKS worker node"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = [
            "ec2.amazonaws.com",
            "eks.amazonaws.com"
          ]
        }
      }
    ]
  })
}