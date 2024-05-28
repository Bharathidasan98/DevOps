#resource "aws_cloudfront_distribution" "elb_distribution" {
#
# origin {
#  domain_name = var.var_domain_name
#  origin_id   = var.var_domain_id
#}
#enabled             = var.var_enabled
#is_ipv6_enabled     = var.var_ipv6_status
#default_root_object = var.var_root_object
#
#default_cache_behavior {
#  cached_methods   = var.var_cache_method_d
#  allowed_methods  = var.var_allowed_methods_d
#  target_origin_id = var.var_target_origin_id_d
#
#  forwarded_values {
#    query_string = false
#
#    cookies {
#      forward = "none"
#    }
#  }
#
#  viewer_protocol_policy = "allow-all"
#  min_ttl                = 1
#  default_ttl            = 3600
#  max_ttl                = 86400
#}
#
#
#dynamic "ordered_cache_behavior" {
#  for_each = var.var_ordered_cache_behavior
#  content {
#    path_pattern     = lookup(ordered_cache_behavior.value, "path_pattern", null)
#    allowed_methods  = lookup(ordered_cache_behavior.value, "allowed_methods", null)
#    cached_methods   = lookup(ordered_cache_behavior.value, "cached_methods", null)
#    target_origin_id = lookup(ordered_cache_behavior.value, "target_origin_id", null)
#
#    forwarded_values {
#      query_string = lookup(ordered_cache_behavior.value, "query_string", null)
#      headers      = lookup(ordered_cache_behavior.value, "headers", null)
#
#      cookies {
#        forward = "none"
#      }
#    }
#    #      lambda_function_association {
#    #        event_type   = var.var_event_type
#    #        lambda_arn   = aws_lambda_function.example.qualified_arn
#    #        include_body = false
#    #      }
#
#    min_ttl                = 0
#    default_ttl            = 86400
#    max_ttl                = 31536000
#    compress               = true
#    viewer_protocol_policy = "redirect-to-https"
#  }
#}
#
#restrictions {
#  geo_restriction {
#    restriction_type = "whitelist"
#    locations        = ["US", "CA", "GB", "DE"]
#  }
#}
#
#viewer_certificate {
#  cloudfront_default_certificate = true
#}
#}
resource "aws_cloudfront_distribution" "distribution" {
  for_each = var.var_cdn_cdn
  aliases  = each.value.aliases
  origin {
    domain_name         = each.value.domain_name #lookup(var_cdn_cdn.value, "domain_name", null )
    origin_id           = each.value.origin_id
    connection_attempts = each.value.connection_attempts
    connection_timeout  = each.value.connection_timeout
    #  s3_origin_config {
    #    origin_access_identity = each.value.s3_origin_config !=null ? each.value.s3_origin_config.origin_access_identity  : ""
    #}
    dynamic "s3_origin_config" {
      for_each = each.value.s3_origin_config != null ? [each.value.s3_origin_config] : []
      content {
        origin_access_identity = s3_origin_config.value.origin_access_identity
      }
    }
    dynamic "custom_origin_config" {
      for_each = each.value.custom_origin_config != null ? [each.value.custom_origin_config] : []
      content {
        http_port                = custom_origin_config.value.http_port
        https_port               = custom_origin_config.value.https_port
        origin_keepalive_timeout = custom_origin_config.value.origin_keepalive_timeout
        origin_protocol_policy   = custom_origin_config.value.origin_protocol_policy
        origin_read_timeout      = custom_origin_config.value.origin_read_timeout
        origin_ssl_protocols     = custom_origin_config.value.origin_ssl_protocols
      }
    }
    #       dynamic "s3_origin_config" {
    #      for_each = each.value.s3_origin_config != null ? [each.value.s3_origin_config] : []
    #
    #      content {
    #        origin_access_identity = s3_origin_config.value.origin_access_identity
    #      }
    #    }
    #
    #    dynamic "custom_origin_config" {
    #      for_each = each.value.custom_origin_config != null ? [each.value.custom_origin_config] : []
    #
    #      content {
    #        http_port                = custom_origin_config.value.http_port
    #        https_port               = custom_origin_config.value.https_port
    #        origin_keepalive_timeout = custom_origin_config.value.origin_keepalive_timeout
    #        origin_protocol_policy   = custom_origin_config.value.origin_protocol_policy
    #        origin_read_timeout      = custom_origin_config.value.origin_read_timeout
    #        origin_ssl_protocols     = custom_origin_config.value.origin_ssl_protocols
    #      }
    #    }
  }

  enabled             = each.value.enabled
  is_ipv6_enabled     = each.value.is_ipv6_enabled
  http_version        = each.value.http_version
  default_root_object = each.value.default_root_object

  default_cache_behavior {
    cached_methods   = each.value.cached_methods
    allowed_methods  = each.value.allowed_methods
    target_origin_id = each.value.target_origin_id
    # cache_policy_id = each.value.cache_policy_id
    compress                 = each.value.compress
    min_ttl                  = each.value.min_ttl
    default_ttl              = each.value.default_ttl
    max_ttl                  = each.value.max_ttl
    viewer_protocol_policy   = each.value.viewer_protocol_policy
    smooth_streaming         = each.value.smooth_streaming
    origin_request_policy_id = each.value.origin_request_policy_id
    forwarded_values {
      query_string = each.value.query_string

      cookies {
        forward = each.value.forward
      }
    }

  }
  dynamic "ordered_cache_behavior" {
    for_each = each.value.var_ordered_cache_behavior
    content {
      path_pattern           = lookup(ordered_cache_behavior.value, "path_pattern", null)
      allowed_methods        = lookup(ordered_cache_behavior.value, "allowed_methods", null)
      cached_methods         = lookup(ordered_cache_behavior.value, "cached_methods", null)
      target_origin_id       = lookup(ordered_cache_behavior.value, "target_origin_id", null)
      cache_policy_id        = lookup(ordered_cache_behavior.value, "cache_policy_id", null)
      compress               = lookup(ordered_cache_behavior.value, "compress", null)
      min_ttl                = lookup(ordered_cache_behavior.value, "min_ttl", null)
      default_ttl            = lookup(ordered_cache_behavior.value, "default_ttl", null)
      max_ttl                = lookup(ordered_cache_behavior.value, "max_ttl", null)
      viewer_protocol_policy = lookup(ordered_cache_behavior.value, "viewer_protocol_policy", null)
      smooth_streaming       = lookup(ordered_cache_behavior.value, "smooth_streaming", null)
      forwarded_values {
        query_string = lookup(ordered_cache_behavior.value, "query_string", null)
        headers      = lookup(ordered_cache_behavior.value, "headers", null)

        cookies {
          forward = lookup(ordered_cache_behavior.value, "forward", null)
        }
      }
      dynamic "lambda_function_association" {
        #            for_each = { for idx, val in each.value.var_ordered_cache_behavior : idx => val }
        for_each = ordered_cache_behavior.value.lambda_function_association != null ? [ordered_cache_behavior.value.lambda_function_association] : []
        #    for_each = lookup(ordered_cache_behavior.value, "lambda_function_association", {})
        content {
          event_type = lambda_function_association.value.event_type #lookup(ordered_cache_behavior.lambda_function_association.value, "event_type", null)
          # viewer-request, origin-request, viewer-response, origin-response.
          lambda_arn   = lambda_function_association.value.lambda_arn   #lookup(ordered_cache_behavior.lambda_function_association.value, "lambda_arn", null)
          include_body = lambda_function_association.value.include_body #lookup(ordered_cache_behavior.lambda_function_association.value, "include_body", null)
        }
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = each.value.restriction_type
      locations        = each.value.locations
    }
  }
  price_class      = each.value.price_class
  retain_on_delete = each.value.retain_on_delete
  staging          = each.value.staging
  viewer_certificate {
    cloudfront_default_certificate = each.value.cloudfront_default_certificate
    acm_certificate_arn            = each.value.acm_certificate_arn
    minimum_protocol_version       = each.value.minimum_protocol_version
    ssl_support_method             = each.value.ssl_support_method
  }
}