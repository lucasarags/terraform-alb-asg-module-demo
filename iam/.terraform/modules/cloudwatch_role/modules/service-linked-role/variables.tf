variable "aws_service_name" {
  description = "The AWS service to which this role is attached. You use a string similar to a URL but without the http:// in front. For example: elasticbeanstalk.amazonaws.com."
  type        = string
}

variable "custom_suffix" {
  type    = string
  default = ""
}

variable "description" {
  type    = string
  default = ""
}
