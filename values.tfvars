# Lambda configuration
region = "eu-west-1"

function_name = "XeroxPriceHandler"

function_handler = "com.amazonaws.salmon.xerox.lambda.price.XeroxPriceHandler::handleRequest"

function_runtime = "java8"

function_filename = "PriceXMLConversionHandler-1.0.0.jar"

# Environment variables
api_user = "username"

api_password = "thsh@34Hhdg^%"

currency = "USD"

price_xml_bucket = "xerox-price-xml-bucket"

price_csv_bucket = "xerox-price-csv-processing-bucket"

queue_name = "pricequeue"

rest_api_url = "https://testxerox.salnl.ne/INTERSHOP/rest/WFS/"

# $LATEST Lambda input trigger
lamdba_trigger_bucket = "xerox-price-csv-input-bucket"

# SNS Topics
xml_conversion_fail = "PriceXMLConversionFail"

xml_conversion_success = "PriceXMLConversionSuccess"

file_transfer_error = "FileTransferError"

# DEV Alias configs
dev_alias_name = "DEV"

test_alias_name = "TEST"

prod_alias_name = "PROD"
