# Price queue
resource "aws_sqs_queue" "pricequeue" {
  name = "${var.queue_name}"

  tags = {
    Environment = "production"
  }
}

resource "aws_s3_bucket" "s3_bucket_price_xml" {
  bucket = "${var.price_xml_bucket}"
}

# SNS topics
resource "aws_sns_topic" "price_xml_conversion_fail" {
  name = "${var.xml_conversion_fail}"
}

resource "aws_sns_topic" "price_xml_conversion_success" {
  name = "${var.xml_conversion_success}"
}

resource "aws_sns_topic" "file_transfer_error" {
  name = "${var.file_transfer_error}"
}
