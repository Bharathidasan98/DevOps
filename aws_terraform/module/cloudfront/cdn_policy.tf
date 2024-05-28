resource "aws_cloudfront_cache_policy" "cdn_policy" {
  for_each    = var.var_cdn_policy
  comment     = each.value.comment
  default_ttl = each.value.default_ttl
  max_ttl     = each.value.max_ttl
  min_ttl     = each.value.min_ttl
  name        = each.value.name
  dynamic "parameters_in_cache_key_and_forwarded_to_origin" {
    for_each = each.value.parameters_in_cache_key_and_forwarded_to_origin
    content {
      cookies_config {
        cookie_behavior = parameters_in_cache_key_and_forwarded_to_origin.value.cookie_behavior
        cookies {
          items = parameters_in_cache_key_and_forwarded_to_origin.value.cookies != null ? parameters_in_cache_key_and_forwarded_to_origin.value.cookies.items : []
        }

      }
      enable_accept_encoding_brotli = parameters_in_cache_key_and_forwarded_to_origin.value.enable_accept_encoding_brotli
      enable_accept_encoding_gzip   = parameters_in_cache_key_and_forwarded_to_origin.value.enable_accept_encoding_gzip
      headers_config {
        header_behavior = parameters_in_cache_key_and_forwarded_to_origin.value.header_behavior
        headers {
          items = parameters_in_cache_key_and_forwarded_to_origin.value.headers != null ? parameters_in_cache_key_and_forwarded_to_origin.value.headers.items : []
        }
      }
      query_strings_config {
        query_string_behavior = parameters_in_cache_key_and_forwarded_to_origin.value.query_string_behavior
        query_strings {
          items = parameters_in_cache_key_and_forwarded_to_origin.value.query_strings != null ? parameters_in_cache_key_and_forwarded_to_origin.value.query_strings.items : []
        }
      }
    }
  }
}
output "op_cache_policy_id" {
  value = {
    for k, v in aws_cloudfront_cache_policy.cdn_policy : k => v.id
  }
}
#module "cdn" {
#  source = "../../modules/cloudfront"
#  var_cdn_cdn = {
#    test = {
#      aliases             = ["cdn.hevo.io", "cdn.hevodata.com"]
#      domain_name         = "cdn.hevodata.com.s3.amazonaws.com"
#      origin_id           = "S3-cdn.hevodata.com"
#      connection_attempts = 3
#      connection_timeout  = 10
#      s3_origin_config = {
#        origin_access_identity = "origin-access-identity/cloudfront/E3CF8CIJB9TDOF"
#      }
#      #origin_access_control_id = aws_cloudfront_origin_access_control.default.id
#      enabled                        = true
#      is_ipv6_enabled                = true
#      default_root_object            = "/"
#      cached_methods                 = ["GET", "HEAD"]
#      allowed_methods                = ["GET", "HEAD"]
#      target_origin_id               = "S3-cdn.hevodata.com"
#      compress                       = false
#      query_string                   = false
#      forward                        = "none"
#      viewer_protocol_policy         = "redirect-to-https"
#      min_ttl                        = 0
#      default_ttl                    = 86400
#      max_ttl                        = 31536000
#      http_version                   = "http2and3"
#      price_class                    = "PriceClass_200"
#      response_headers_policy_id     = "60669652-455b-4ae9-85a4-c4c02393f86c"
#      smooth_streaming               = false
#      retain_on_delete               = false
#      staging                        = false
#      restriction_type               = "none"
#      acm_certificate_arn            = "arn:aws:acm:us-east-1:393309748692:certificate/f0271381-26e2-4d0e-b19d-5c3518755b8f"
#      cloudfront_default_certificate = false
#      minimum_protocol_version       = "TLSv1.2_2021"
#      ssl_support_method             = "sni-only"
#      var_ordered_cache_behavior = [
#        {
#          allowed_methods            = ["GET", "HEAD"]
#          cache_policy_id            = "${aws_cloudfront_cache_policy.tfer--6b0eaac0-c63f-4281-936c-ef8da7b7905e.id}"
#          cached_methods             = ["GET", "HEAD"]
#          compress                   = true
#          default_ttl                = 0
#          max_ttl                    = 0
#          min_ttl                    = 0
#          path_pattern               = "/integrations/logo/*"
#          response_headers_policy_id = "60669652-455b-4ae9-85a4-c4c02393f86c"
#          smooth_streaming           = false
#          target_origin_id           = "S3-cdn.hevodata.com"
#          viewer_protocol_policy     = "redirect-to-https"
#          }, {
#          allowed_methods            = ["GET", "HEAD"]
#          cached_methods             = ["GET", "HEAD"]
#          compress                   = true
#          default_ttl                = 86400
#          max_ttl                    = 31536000
#          min_ttl                    = 0
#          path_pattern               = "*.js"
#          response_headers_policy_id = "60669652-455b-4ae9-85a4-c4c02393f86c"
#          smooth_streaming           = false
#          target_origin_id           = "S3-cdn.hevodata.com"
#          viewer_protocol_policy     = "redirect-to-https"
#          forward                    = "none"
#          query_string               = false
#      }]
#    },
#    tfer--EFIECHIC5W79K = {
#      aliases             = ["*.hevo.io", "hevodata.com"]
#      domain_name         = "website-123371169.ap-southeast-1.elb.amazonaws.com"
#      origin_id           = "website-123371169.ap-southeast-1.elb.amazonaws.com"
#      connection_attempts = 3
#      connection_timeout  = 10
#      custom_origin_config = {
#        http_port                = 80
#        https_port               = 443
#        origin_keepalive_timeout = 5
#        origin_protocol_policy   = "match-viewer"
#        origin_read_timeout      = 30
#        origin_ssl_protocols     = ["TLSv1.2"]
#      }
#      #origin_access_control_id = aws_cloudfront_origin_access_control.default.id
#      #default_cache_behavior attributes
#      cached_methods             = ["GET", "HEAD"]
#      allowed_methods            = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
#      target_origin_id           = "S3-cdn.hevodata.com"
#      compress                   = false
#      query_string               = false
#      cache_policy_id            = "${aws_cloudfront_cache_policy.tfer--4135ea2d-6df8-44a3-9df3-4b5a84be39ad.id}"
#      origin_request_policy_id   = "216adef6-5c7f-47e4-b989-5492eafa07d3"
#      response_headers_policy_id = "60669652-455b-4ae9-85a4-c4c02393f86c"
#      forward                    = "none"
#      viewer_protocol_policy     = "allow-all"
#      smooth_streaming           = false
#      min_ttl                    = 0
#      default_ttl                = 0
#      max_ttl                    = 0
#      #default_cache_behavior attributes ends
#      // ...global attributes start...//
#      default_root_object = "/"
#      retain_on_delete    = false
#      staging             = false
#      http_version        = "http2"
#      enabled             = true
#      is_ipv6_enabled     = true
#      price_class         = "PriceClass_200"
#      restriction_type    = "none" // ...global attributes ends...//
#      # viewer_certificate attributes starts
#      acm_certificate_arn            = "arn:aws:acm:us-east-1:393309748692:certificate/8c817c57-7a94-41d9-9fe3-9c858932f878"
#      cloudfront_default_certificate = false
#      minimum_protocol_version       = "TLSv1.2_2021"
#      ssl_support_method             = "sni-only"
#      # viewer_certificate attributes ends
#      var_ordered_cache_behavior = [{
#        allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
#        cache_policy_id = "${aws_cloudfront_cache_policy.tfer--818ef4b9-2a75-448a-ad55-a9cc27be2d85.id}"
#        cached_methods  = ["GET", "HEAD"]
#        compress        = true
#        default_ttl     = 0
#        lambda_function_association = {
#          event_type   = "origin-response"
#          include_body = false
#          lambda_arn   = "arn:aws:lambda:us-east-1:393309748692:function:asia-dev-blog-cache-html:3"
#        }
#        max_ttl                  = 0
#        min_ttl                  = 0
#        origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
#        path_pattern             = "/blog/*"
#        smooth_streaming         = false
#        target_origin_id         = "website-123371169.ap-southeast-1.elb.amazonaws.com"
#        viewer_protocol_policy   = "allow-all"
#        },
#        {
#          allowed_methods          = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
#          cache_policy_id          = "${aws_cloudfront_cache_policy.tfer--818ef4b9-2a75-448a-ad55-a9cc27be2d85.id}"
#          cached_methods           = ["GET", "HEAD"]
#          compress                 = true
#          default_ttl              = 0
#          max_ttl                  = 0
#          min_ttl                  = 0
#          origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
#          path_pattern             = "/learn/*.js"
#          smooth_streaming         = false
#          target_origin_id         = "website-123371169.ap-southeast-1.elb.amazonaws.com"
#          viewer_protocol_policy   = "allow-all"
#        },
#        {
#          allowed_methods          = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
#          cache_policy_id          = "${aws_cloudfront_cache_policy.tfer--818ef4b9-2a75-448a-ad55-a9cc27be2d85.id}"
#          cached_methods           = ["GET", "HEAD"]
#          compress                 = "true"
#          default_ttl              = 0
#          max_ttl                  = 0
#          min_ttl                  = 0
#          origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
#          path_pattern             = "/blog/*.css"
#          smooth_streaming         = "false"
#          target_origin_id         = "website-123371169.ap-southeast-1.elb.amazonaws.com"
#          viewer_protocol_policy   = "allow-all"
#        },
#        {
#          allowed_methods          = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
#          cache_policy_id          = "${aws_cloudfront_cache_policy.tfer--818ef4b9-2a75-448a-ad55-a9cc27be2d85.id}"
#          cached_methods           = ["GET", "HEAD"]
#          compress                 = true
#          default_ttl              = 0
#          max_ttl                  = 0
#          min_ttl                  = 0
#          origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
#          path_pattern             = "/learn/*.css"
#          smooth_streaming         = false
#          target_origin_id         = "website-123371169.ap-southeast-1.elb.amazonaws.com"
#          viewer_protocol_policy   = "allow-all"
#          }, {
#          allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
#          cache_policy_id = "${aws_cloudfront_cache_policy.tfer--818ef4b9-2a75-448a-ad55-a9cc27be2d85.id}"
#          cached_methods  = ["GET", "HEAD"]
#          compress        = "true"
#          default_ttl     = 0
#          lambda_function_association = {
#            event_type   = "origin-response"
#            include_body = false
#            lambda_arn   = "arn:aws:lambda:us-east-1:393309748692:function:asia-dev-blog-cache-html:3"
#          }
#          max_ttl                  = 0
#          min_ttl                  = 0
#          origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
#          path_pattern             = "/learn/*"
#          smooth_streaming         = false
#          target_origin_id         = "website-123371169.ap-southeast-1.elb.amazonaws.com"
#          viewer_protocol_policy   = "allow-all"
#          }, {
#          allowed_methods          = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
#          cache_policy_id          = "${aws_cloudfront_cache_policy.tfer--818ef4b9-2a75-448a-ad55-a9cc27be2d85.id}"
#          cached_methods           = ["GET", "HEAD"]
#          compress                 = true
#          default_ttl              = 0
#          max_ttl                  = 0
#          min_ttl                  = 0
#          origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
#          path_pattern             = "/blog/*.js"
#          smooth_streaming         = false
#          target_origin_id         = "website-123371169.ap-southeast-1.elb.amazonaws.com"
#          viewer_protocol_policy   = "allow-all"
#      }]
#    }
#  }
#}