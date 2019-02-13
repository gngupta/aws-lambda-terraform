# Lambda configuration
region = "eu-west-1"
function_name = "XeroxPriceHandler"
function_handler = "com.amazonaws.salmon.xerox.lambda.price.XeroxPriceHandler::handleRequest"
function_runtime = "java8"
function_filename ="PriceXMLConversionHandler-1.0.0.jar"

# Environment variables
api_user = "username"
api_password = "thsh@34Hhdg^%"
currency = "USD"
price_csv_bucket = "xerox-price-csv-processing-bucket"

# Lambda trigger
lamdba_trigger_bucket = "xerox-price-csv-input-bucket"