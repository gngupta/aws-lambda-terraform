# PROD alias for lambda function
resource "aws_lambda_alias" "prod_alias" {
  name             = "PROD"
  description      = "Alias for PROD env"
  function_name    = "${aws_lambda_function.lambda_function.arn}"
  function_version = "$LATEST"
}

# S3 bucket for PROD alias
resource "aws_s3_bucket" "prod_s3_bucket_price_csv_processing" {
  bucket = "prod-xerox-price-csv-processing-bucket"
}

# Allow prod_s3_bucket to invoke prod_alias of lambda function
resource "aws_lambda_permission" "allow_execution_from_prod_s3_bucket" {
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_alias.prod_alias.arn}"
  principal     = "s3.amazonaws.com"
  source_arn    = "${aws_s3_bucket.prod_s3_bucket_price_csv_processing.arn}"
}

# Send notification from prod_s3_bucket to prod_alias of lambda function
resource "aws_s3_bucket_notification" "prod_bucket_terraform_notification" {
  bucket = "${aws_s3_bucket.prod_s3_bucket_price_csv_processing.id}"

  lambda_function {
    lambda_function_arn = "${aws_lambda_alias.prod_alias.arn}"
    events              = ["s3:ObjectCreated:*"]
  }
}
