module "lambda" {
  source             = "/Users/Bharathidasan.m/mydiary/terraform/terraform_aws_cdn/module/lambda@edge"
  var_lambda_role    = "lambda_role"
  var_lamda_rolename = "test"
  var_lambda_name    = "mylambdafunc112"
  var_handler        = "index.test"
}