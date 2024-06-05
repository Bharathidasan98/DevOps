data "archive_file" "lambda_data" {
  for_each = var.var_archive_file
  type        = "zip"
  source_file = each.value.source_file
  output_path = each.value.output_path
}
locals {
  lambda = {
     for name, details in var.var_lambda_function : name => {
    filename = details.filename
    role = details.role
    handler = details.handler
    runtime = details.runtime
    publish = details.publish
    }
  }
}
resource "aws_lambda_function" "lambda_function" {
  for_each = local.lambda
  filename      = each.value.filename
  function_name = each.key
  role          = each.value.role
  handler       = each.value.handler
  runtime = each.value.runtime
  publish = each.value.publish
}
output "op_lambda_arn" {
  value = {
    for k,v in aws_lambda_function.lambda_function : k => v.qualified_arn
  }
}

#data "aws_iam_policy_document" "assume_role" {
#  statement {
#    effect = "Allow"
#    principals {
#      type        = "Service"
#      identifiers = ["lambda.amazonaws.com"]
#    }
#    actions = ["sts:AssumeRole"]
#  }
#}
#resource "aws_iam_role" "iam_for_lambda" {
#  name               = "lambda_role"
#  assume_role_policy = data.aws_iam_policy_document.assume_role.json
#}
#
#locals {
#  lambda = {
#    for name, details in var.var_lambda_function : name => {
#      filename         = details.filename
#      function_name    = details.function_name
#      role             = details.role
#      handler          = details.handler
#    #  source_code_hash = details.source_code_hash
#      runtime          = details.runtime
#    }
#  }
#}
#resource "aws_lambda_function" "lambda" {
#  for_each = local.lambda
#  #name= each.name
#  filename      = each.value.filename
#  function_name = each.value.function_name
#  role          = each.value.role
#  #  role          = "${aws_iam_role.iam_for_lambda.arn}"
#  handler          = each.value.handler
#  #source_code_hash = each.value.source_code_hash
#  #  source_code_hash = "${data.archive_file.lambda.output_base64sha256}"
#  runtime = each.value.runtime
#  #  filename      = lookup(var.var_lambda_function.value, "filename", null )
#  #  function_name = lookup(var.var_lambda_function.value, "function_name", null )
#  #  role          = lookup(var.var_lambda_function.value, "role", null)
#  ##  role          = "${aws_iam_role.iam_for_lambda.arn}"
#  #  handler       = lookup(var.var_lambda_function.value, "handler", null)
#  #  source_code_hash = lookup(var.var_lambda_function.value, "source_code_hash", null)
#  ##  source_code_hash = "${data.archive_file.lambda.output_base64sha256}"
#  #  runtime = lookup(var.var_lambda_function.value, "runtime", null)
#}
#data "archive_file" "lambda_data" {
#  for_each = var.var_archive_file
#    type        = "zip"
#    source_file = each.value.source_file
#    output_path = each.value.output_path
#}
#output "op_output_base64sha256" {
#  value = {
#    #id_output_base64sha256 = data.archive_file.lambda_data["default"].output_base64sha256
#     for k, v in data.archive_file.lambda_data : k => v.output_base64sha256
#  }
#}