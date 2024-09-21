########
# Locals
########
locals {
  shared_tags = {
    "root:owner"       = "Rob Burger"
    "root:provisioner" = "Terraform"
    "root:system"      = "rp-ta"
    "root:workspace"   = "rp-ta"
  }
}
