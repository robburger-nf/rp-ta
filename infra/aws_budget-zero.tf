#####################
# Resources & Modules
#####################
resource "aws_budgets_budget" "zero" {
  name = "zero-budget"

  budget_type  = "COST"
  limit_amount = "0"
  limit_unit   = "USD"
  time_unit    = "DAILY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 0
    threshold_type             = "ABSOLUTE_VALUE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [var.budget_notification_email]
  }

  tags = merge(
    {
      "Name" = "zero-budget"
    },
    local.shared_tags,
  )
}
