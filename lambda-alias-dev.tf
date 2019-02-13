# DEV alias for lambda function
resource "aws_lambda_alias" "dev_alias" {
  name             = "DEV"
  description      = "Alias for DEV env"
  function_name    = "${aws_lambda_function.lambda_function.arn}"
  function_version = "$LATEST"
}

# S3 bucket for DEV alias
resource "aws_s3_bucket" "dev_s3_bucket_price_csv_processing" {
  bucket = "dev-xerox-price-csv-processing-bucket"
}

# Allow dev_s3_bucket to invoke dev_alias of lambda function
resource "aws_lambda_permission" "allow_execution_from_dev_s3_bucket" {
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda_function.function_name}"
  principal     = "s3.amazonaws.com"
  source_arn    = "${aws_s3_bucket.dev_s3_bucket_price_csv_processing.arn}"
  qualifier     = "${aws_lambda_alias.dev_alias.name}"
}

# Send notification from dev_s3_bucket to dev_alias of lambda function
resource "aws_s3_bucket_notification" "dev_bucket_terraform_notification" {
  bucket = "${aws_s3_bucket.dev_s3_bucket_price_csv_processing.id}"

  lambda_function {
    lambda_function_arn = "${aws_lambda_alias.dev_alias.arn}"
    events              = ["s3:ObjectCreated:*"]
  }
}
