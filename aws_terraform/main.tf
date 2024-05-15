module "cdn" {
  source = "/Users/Bharathidasan.m/mydiary/terraform/terraform_aws_cdn/module/cloudfront/"

  #locals {
  #  s3_origin_id = "myS3Origin"
  #}
  var_domain_id          = "myS3Origin"
  var_domain_name        = "*.hevodata.com"
  var_enabled            = true
  var_ipv6_status        = true
  var_root_object        = "index.html"
  var_event_type         = "viewer-request"
  var_cache_method_d     = ["GET", "HEAD"]
  var_allowed_methods_d  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
  var_target_origin_id_d = "myS3Origin"

  var_ordered_cache_behavior = [
    {
      path_pattern     = "/learn/*"
      allowed_methods  = ["GET", "HEAD", "OPTIONS"]
      cached_methods   = ["GET", "HEAD"]
      target_origin_id = "myS3Origin"
      query_string     = "false"
      headers          = ["origin"]
    },
    {
      path_pattern     = "/blog/*"
      allowed_methods  = ["GET", "HEAD", "OPTIONS"]
      cached_methods   = ["GET", "HEAD"]
      target_origin_id = "myS3Origin"
      query_string     = "false"
      headers          = ["origin"]
    }
  ]
}
