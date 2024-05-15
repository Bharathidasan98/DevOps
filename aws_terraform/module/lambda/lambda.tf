data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}
resource "aws_iam_role" "iam_for_lambda" {
  name               = var.var_lamda_rolename
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda.js"
  output_path = "lambda_function_payload.zip"
}
resource "aws_lambda_function" "test_lambda" {
  filename      = data.archive_file.lambda.output_path
  function_name = var.var_lambda_name
  role          = "${aws_iam_role.iam_for_lambda.arn}"
  handler       = var.var_handler
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime = "nodejs18.x"
}