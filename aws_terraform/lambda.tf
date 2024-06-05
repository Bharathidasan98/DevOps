#module "lambda" {
#  source = "/Users/Bharathidasan.m/mydiary/DevOps/terraform_aws_cdn/module/lambda@edge"
#
#  var_lambda_function = {
#    test1 = {
#      filename      = "lambda_function_payload.zip"
#      function_name = "us-dev-lambda-1"
#      role          = "arn:aws:iam::393333748692:role/a_soc"
#      handler       = "index.test"
#      #      source_code_hash = "${module.lambda.archive_file.lambda_data["default"].output_base64sha256}"
#      runtime = "nodejs18.x"
#
#    },
#    test2 = {
#      filename      = "lambda_function_payload.zip"
#      function_name = "us-dev-lambda-2"
#      role          = "arn:aws:iam::393333748692:role/a_soc"
#      handler       = "index.test"
#      #   source_code_hash = module.lambda.op_output_base64sha256
#      runtime = "nodejs18.x"
#    }
#  }
#
#  #data "archive_file" "lambda" {
#  #  type        = "zip"
#  #  source_file = "lambda.js"                   #var.var_source_file
#  #  output_path = "lambda_function_payload.zip" #var.var_output_path
#  #}
#  var_archive_file = {
#    default = {
#      source_file = "lambda.js"
#      output_path = "lambda_function_payload.zip"
#    }
#  }
#}

module "lambda" {
  source = "../../modules/lambda"

  var_lambda_function = {
    asia-dev-blog-cache-html = {
      filename         = "../../environments/us/files/lambdacode/lambda_function_payload.zip"
      role             = "arn:aws:iam::393309748692:role/service-role/asia-dev-blog-cache-html-role-85i81taw"
      handler          = "lambda_function.lambda_handler"
      runtime          = "python3.8"
      publish          = false
    }
  }
  var_archive_file = {
    default = {
      source_file = "../../environments/us/files/lambdacode/lambda_function.py"
      output_path = "../../environments/us/files/lambdacode/lambda_function_payload.zip"
    }
  }
}
