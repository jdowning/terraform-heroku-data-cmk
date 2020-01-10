provider "aws" {
  version = "~> 2.0"
  region  = var.region
}

resource "aws_kms_key" "heroku_data" {
  description = "CMK for Heroku Data"
  policy      = data.aws_iam_policy_document.heroku_data.json
}

output "cmk_arn" {
  value = aws_kms_key.heroku_data.arn
}

data "aws_iam_policy_document" "heroku_data" {
  statement {
    sid       = "Allow usage of KMS from root account"
    effect    = "Allow"
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_id}:root"]
    }
    actions = [
      "kms:*"
    ]
  }

  statement {
    sid       = "Allow usage of KMS from Heroku Data account"
    effect    = "Allow"
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam:${var.heroku_account_id}:root"]
    }
    actions = [
      "kms:DescribeKey",
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey*",
      "kms:ReEncrypt*"
    ]
  }

  statement {
    sid       = "Allow AWS services in Heroku Data account to create grants"
    effect    = "Allow"
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam:${var.heroku_account_id}:root"]
    }
    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]
    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }
  }
}
