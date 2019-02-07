# Set cloud provider AWS
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

# Create IAM role for lambda function
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam-for-lambda-xerox-price-import"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
}
EOF
}

# Create lambda function
resource "aws_lambda_function" "lambda_function" {
  filename         = "PriceXMLConversionHandler-1.0.0.jar"
  function_name    = "XeroxPriceHandler"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "com.amazonaws.salmon.xerox.lambda.price.XeroxPriceHandler::handleRequest"
  source_code_hash = "${base64sha256(file("PriceXMLConversionHandler-1.0.0.jar"))}"
  runtime          = "java8"

  environment {
    variables = {
      API_PASSWORD = "a5682hbshjggfusua897"
    }
  }
}

# Attach policy to lambda role 
resource "aws_iam_role_policy_attachment" "lambda_basic_execution_role" {
  role       = "${aws_iam_role.iam_for_lambda.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda_function.arn}"
  principal     = "s3.amazonaws.com"
  source_arn    = "${aws_s3_bucket.prod_s3_bucket_price_csv_processing.arn}"
}

# S3 bucket for PROD alias
resource "aws_s3_bucket" "prod_s3_bucket_price_csv_processing" {
  bucket = "prod-xerox-price-csv-processing-bucket"
}

resource "aws_s3_bucket_notification" "bucket_terraform_notification" {
  bucket = "${aws_s3_bucket.prod_s3_bucket_price_csv_processing.id}"

  lambda_function {
    lambda_function_arn = "${aws_lambda_function.lambda_function.arn}"
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = "csv"
  }
}
