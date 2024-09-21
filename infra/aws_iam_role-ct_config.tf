# See: https://docs.aws.amazon.com/controltower/latest/userguide/roles-how.html#config-role-for-organizations

######
# Data
######
data "aws_iam_policy_document" "assume_role_config_config" {
  statement {
    sid = "AllowAssumeRole"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
  }
}

#####################
# Resources & Modules
#####################
resource "aws_iam_role" "controltower_config" {
  name               = "AWSControlTowerConfigAggregatorRoleForOrganizations"
  path               = "/service-role/"
  assume_role_policy = data.aws_iam_policy_document.assume_role_config_config.json

  tags = merge(
    {
      Name                 = "AWSControlTowerConfigAggregatorRoleForOrganizations"
      "root:iam-role:path" = "/service-role/"
    },
    local.shared_tags,
  )
}

resource "aws_iam_role_policy_attachment" "controltower_config_service_role" {
  role       = aws_iam_role.controltower_config.name
  policy_arn = "arn:aws:iam::aws:policy/AWSConfigRoleForOrganizations"
}
