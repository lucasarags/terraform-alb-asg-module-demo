provider "aws" {
  region = var.region
}

module "role" {
  source = "../../modules/service-linked-role"
  # changed to autoscaling.amazonaws.com because it is one of the few service linked roles that supports the custom suffix
  aws_service_name = "autoscaling.amazonaws.com"
  custom_suffix    = var.custom_suffix
}
