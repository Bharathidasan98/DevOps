module "cdn" {
  source = "/Users/Bharathidasan.m/mydiary/DevOps/terraform_aws_cdn/module/cloudfront/"

  #locals {
  #  s3_origin_id = "myS3Origin"
  #}

  #var_domain_id          = "myS3Origin"
  #var_domain_name        = "*.hevodata.com"
  #var_enabled            = true
  #var_ipv6_status        = true
  #var_root_object        = "index.html"
  #var_event_type         = "viewer-request"
  #var_cache_method_d     = ["GET", "HEAD"]
  #var_allowed_methods_d  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
  #var_target_origin_id_d = "myS3Origin"

  #  var_ordered_cache_behavior = [
  #    {
  #      path_pattern     = "/learn/*"
  #      allowed_methods  = ["GET", "HEAD", "OPTIONS"]
  #      cached_methods   = ["GET", "HEAD"]
  #      target_origin_id = "myS3Origin"
  #      query_string     = "false"
  #      headers          = ["origin"]
  #    },
  #    {
  #      path_pattern     = "/blog/*"
  #      allowed_methods  = ["GET", "HEAD", "OPTIONS"]
  #      cached_methods   = ["GET", "HEAD"]
  #      target_origin_id = "myS3Origin"
  #      query_string     = "false"
  #      headers          = ["origin"]
  #    }
  #  ]
  var_cdn_cdn = {
    test = {
      aliases             = ["cdn.hevo.io", "cdn.hevodata.com"]
      domain_name         = "cdn.hevodata.com.s3.amazonaws.com"
      origin_id           = "S3-cdn.hevodata.com"
      connection_attempts = 3
      connection_timeout  = 10
      s3_origin_config = {
        origin_access_identity = "origin-access-identity/cloudfront/E3CF8CIJB9TDOF"
      }
      #origin_access_control_id = aws_cloudfront_origin_access_control.default.id
      enabled                        = true
      is_ipv6_enabled                = true
      default_root_object            = "/"
      cached_methods                 = ["GET", "HEAD"]
      allowed_methods                = ["GET", "HEAD"]
      target_origin_id               = "S3-cdn.hevodata.com"
      compress                       = false
      query_string                   = false
      forward                        = "none"
      viewer_protocol_policy         = "redirect-to-https"
      min_ttl                        = 0
      default_ttl                    = 86400
      max_ttl                        = 31536000
      http_version                   = "http2and3"
      price_class                    = "PriceClass_200"
      response_headers_policy_id     = "60669652-455b-4ae9-85a4-c4c02393f86c"
      smooth_streaming               = false
      retain_on_delete               = false
      staging                        = false
      restriction_type               = "none"
      acm_certificate_arn            = "arn:aws:acm:us-east-1:393309748692:certificate/f0271381-26e2-4d0e-b19d-5c3518755b8f"
      cloudfront_default_certificate = false
      minimum_protocol_version       = "TLSv1.2_2021"
      ssl_support_method             = "sni-only"
      var_ordered_cache_behavior = [
        {
          allowed_methods = ["GET", "HEAD"]
          #  cache_policy_id            = "${aws_cloudfront_cache_policy.tfer--6b0eaac0-c63f-4281-936c-ef8da7b7905e.id}"
          cached_methods             = ["GET", "HEAD"]
          compress                   = true
          default_ttl                = 0
          max_ttl                    = 0
          min_ttl                    = 0
          path_pattern               = "/integrations/logo/*"
          response_headers_policy_id = "60669652-455b-4ae9-85a4-c4c02393f86c"
          smooth_streaming           = false
          target_origin_id           = "S3-cdn.hevodata.com"
          viewer_protocol_policy     = "redirect-to-https"
          forward                    = "none"
          query_string               = false
        }
      ]
    },
    test23 = {
      aliases             = ["pdn.hevo.io", "pdn.hevodata.com"]
      domain_name         = "website-123371169.ap-southeast-1.elb.amazonaws.com"
      origin_id           = "website-123371169.ap-southeast-1.elb.amazonaws.com"
      connection_attempts = 3
      connection_timeout  = 10
      custom_origin_config = {
        http_port                = 80
        https_port               = 443
        origin_keepalive_timeout = 5
        origin_protocol_policy   = "match-viewer"
        origin_read_timeout      = 30
        origin_ssl_protocols     = ["TLSv1.2"]
      }
      #origin_access_control_id = aws_cloudfront_origin_access_control.default.id
      enabled                        = true
      is_ipv6_enabled                = true
      default_root_object            = "/"
      cached_methods                 = ["GET", "HEAD"]
      allowed_methods                = ["GET", "HEAD"]
      target_origin_id               = "S3-cdn.hevodata.com"
      compress                       = false
      query_string                   = false
      forward                        = "none"
      viewer_protocol_policy         = "redirect-to-https"
      min_ttl                        = 0
      default_ttl                    = 86400
      max_ttl                        = 31536000
      http_version                   = "http2and3"
      price_class                    = "PriceClass_200"
      response_headers_policy_id     = "60669652-455b-4ae9-85a4-c4c02393f86c"
      smooth_streaming               = false
      retain_on_delete               = false
      staging                        = false
      restriction_type               = "none"
      acm_certificate_arn            = "arn:aws:acm:us-east-1:393309748692:certificate/f0271381-26e2-4d0e-b19d-5c3518755b8f"
      cloudfront_default_certificate = false
      minimum_protocol_version       = "TLSv1.2_2021"
      ssl_support_method             = "sni-only"
      var_ordered_cache_behavior = [
        {
          allowed_methods = ["GET", "HEAD"]
       #   cache_policy_id = "${aws_cloudfront_cache_policy.cdn_policy["tfer--6b0eaac0-c63f-4281-936c-ef8da7b7905e"].id}"
          cache_policy_id = "${module.cdn.op_cache_policy_id["tfer--6b0eaac0-c63f-4281-936c-ef8da7b7905e"]}"
          cached_methods             = ["GET", "HEAD"]
          compress                   = "true"
          default_ttl                = 0
          max_ttl                    = 0
          min_ttl                    = 0
          path_pattern               = "/integrations/logo/*"
          response_headers_policy_id = "60669652-455b-4ae9-85a4-c4c02393f86c"
          smooth_streaming           = "false"
          target_origin_id           = "S3-cdn.hevodata.com"
          viewer_protocol_policy     = "redirect-to-https"
          forward                    = "none"
          query_string               = false
          lambda_function_association = {
            event_type   = "viewer-request"
            include_body = false
            lambda_arn   = "arn:aws:acm:us-east-1:393309748692:certificate/f0271381-26e2-4d0e-b19d-5c3518755b8f"
          }
        },
        {
          allowed_methods        = ["GET", "HEAD"]
          cached_methods         = ["GET", "HEAD"]
          compress               = "true"
          default_ttl            = 86400
          forward                = "none"
          query_string           = "false"
          max_ttl                = 31536000
          min_ttl                = 0
          path_pattern           = "*.js"
          smooth_streaming       = false
          target_origin_id       = "S3-cdn.hevodata.com"
          viewer_protocol_policy = "redirect-to-https"
        }
      ]
    }
  }
  var_cdn_policy = {
    tfer--6b0eaac0-c63f-4281-936c-ef8da7b7905e = {
      comment     = "first cdn policy"
      default_ttl = 31536000
      max_ttl     = 31536000
      min_ttl     = 1
      name        = "expiry-365d"
      parameters_in_cache_key_and_forwarded_to_origin = {
        test = {
          #  cookies_config = {
          cookie_behavior = "none"
          #        }
          enable_accept_encoding_brotli = true
          enable_accept_encoding_gzip   = true
          #     headers_config = {
          header_behavior = "none"
          #     }
          #     query_string_config = {
          query_string_behavior = "none"
          #      }
        }
      }
    },
    test2 = {
      comment     = "Policy for Amplify Origin"
      default_ttl = "2"
      max_ttl     = "600"
      min_ttl     = "2"
      name        = "Managed-Amplify"
      parameters_in_cache_key_and_forwarded_to_origin = {
        default = {
          cookie_behavior = "all"

          enable_accept_encoding_brotli = "true"
          enable_accept_encoding_gzip   = "true"

          header_behavior = "whitelist"
          headers = {
            items = ["Authorization", "CloudFront-Viewer-Country", "Host"]
          }
          query_string_behavior = "all"
        }
      }
    }
  }
}