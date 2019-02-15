# AWS credentials

variable "access_key" {}

variable "secret_key" {}

variable "region" {}

# Lambda function specific

variable "function_name" {}

variable "function_handler" {}

variable "function_runtime" {}

variable "function_filename" {}

# Lambda environment variables

variable "api_user" {}

variable "api_password" {}

variable "currency" {}

variable "price_xml_bucket" {}

variable "price_csv_bucket" {}

variable "queue_name" {}

variable "rest_api_url" {}

variable "lamdba_trigger_bucket" {}

# SNS topics

variable "xml_conversion_fail" {}

variable "xml_conversion_success" {}

variable "file_transfer_error" {}

# Lambda Alias

variable "dev_alias_name" {}

variable "test_alias_name" {}

variable "prod_alias_name" {}
