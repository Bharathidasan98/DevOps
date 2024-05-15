resource "aws_cloudfront_distribution" "elb_distribution" {
  origin {
    domain_name = var.var_domain_name
    origin_id   = var.var_domain_id
  }
  enabled             = var.var_enabled
  is_ipv6_enabled     = var.var_ipv6_status
  default_root_object = var.var_root_object

  default_cache_behavior {
    cached_methods     = var.var_cache_method_d
    allowed_methods  = var.var_allowed_methods_d
    target_origin_id = var.var_target_origin_id_d

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 1
    default_ttl            = 3600
    max_ttl                = 86400
  }


  dynamic "ordered_cache_behavior" {
    for_each = var.var_ordered_cache_behavior
    content {
      path_pattern     = lookup(ordered_cache_behavior.value, "path_pattern", null)
      allowed_methods  = lookup(ordered_cache_behavior.value, "allowed_methods", null)
      cached_methods   = lookup(ordered_cache_behavior.value, "cached_methods", null)
      target_origin_id = lookup(ordered_cache_behavior.value, "target_origin_id", null)

      forwarded_values {
        query_string = lookup(ordered_cache_behavior.value, "query_string", null)
       headers      = lookup(ordered_cache_behavior.value, "headers", null)

       cookies {
          forward = "none"
       }
      }
#      lambda_function_association {
#        event_type   = var.var_event_type
#        lambda_arn   = aws_lambda_function.example.qualified_arn
#        include_body = false
#      }

      min_ttl                = 0
      default_ttl            = 86400
      max_ttl                = 31536000
      compress               = true
      viewer_protocol_policy = "redirect-to-https"
    }
 }

    restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}


