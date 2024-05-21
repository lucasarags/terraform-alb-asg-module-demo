resource "aws_iam_service_linked_role" "service_linked_role" {
  aws_service_name = var.aws_service_name
  custom_suffix    = var.custom_suffix
  description      = var.description
}
