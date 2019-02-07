# TEST alias for lambda function
resource "aws_lambda_alias" "test_alias" {
  name             = "TEST"
  description      = "Alias for TEST env"
  function_name    = "${aws_lambda_function.lambda_function.arn}"
  function_version = "$LATEST"
}

# S3 bucket for TEST alias
resource "aws_s3_bucket" "test_s3_bucket_price_csv_processing" {
  bucket = "test-xerox-price-csv-processing-bucket"
}

# Allow test_s3_bucket to invoke prod_alias of lambda function
resource "aws_lambda_permission" "allow_execution_from_test_s3_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_alias.test_alias.arn}"
  principal     = "s3.amazonaws.com"
  source_arn    = "${aws_s3_bucket.test_s3_bucket_price_csv_processing.arn}"
}

# Send notification from test_s3_bucket to test_alias of lambda function
resource "aws_s3_bucket_notification" "test_bucket_terraform_notification" {
  bucket = "${aws_s3_bucket.test_s3_bucket_price_csv_processing.id}"

  lambda_function {
    lambda_function_arn = "${aws_lambda_alias.test_alias.arn}"
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = "csv"
  }
}
