terraform {
  backend "s3" {
    bucket         = "runway-s3-bucket"
    key            = "terraform-project-iam"
    region         = "us-east-1"
    dynamodb_table = "tfstate-dynamodb"
    profile        = "arags"
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

module "cloudwatch_access_policy" {
  source = "git::ssh://git@github.azc.ext.hp.com/runway/terraform-aws-iam//modules/iam-policy?ref=v5.1.1"
  
  policy_name = "cloudwatch_access_policy"

  policy_document = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "cloudwatch:ListMetrics",
            "cloudwatch:GetMetricData",
            "cloudwatch:GetMetricStatistics",
            "cloudwatch:DescribeAlarms",
            "ec2:DescribeInstances",
            "elasticloadbalancing:DescribeLoadBalancers",
            "elasticloadbalancing:DescribeTargetGroups",
            "autoscaling:DescribeAutoScalingGroups",
            "logs:DescribeLogStreams",
            "logs:GetLogEvents"
          ],
          "Resource": "*"
        }
      ]
    }
  EOF
}

module "cloudwatch_role" {
  source = "git::ssh://git@github.azc.ext.hp.com/runway/terraform-aws-iam//modules/iam-role?ref=v5.1.1"

  role_name = "CloudWatchRole"
  role_path = "/codeway/"

  policy_arns = [
    module.cloudwatch_access_policy.policy_arn
  ]

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "cloudwatch.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy_attachment" "cloudwatch_policy_attachment" {
  policy_arn = module.cloudwatch_access_policy.policy_arn
  role       = module.cloudwatch_role.role_name
}



