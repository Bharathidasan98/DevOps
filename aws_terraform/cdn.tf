module "cdn" {
  source = "/Users/Bharathidasan.m/mydiary/may2024/terraform/DevOps/aws_terraform/modules/cloudfront"
  var_cdn_distribution = {
    EFIECHIC5W79K = {
      aliases              = ["*.hevodata.com", "hevodata.com"]
      origin = [
        {
          domain_name          = "website-123371169.ap-southeast-1.elb.amazonaws.com"
          origin_id            = "website-123371169.ap-southeast-1.elb.amazonaws.com"
          connection_attempts  = 3
          connection_timeout   = 10
          custom_origin_config = {
            http_port                = 80
            https_port               = 443
            origin_keepalive_timeout = 5
            origin_protocol_policy   = "match-viewer"
            origin_read_timeout      = 30
            origin_ssl_protocols     = ["TLSv1.2"]
          }
        }, {
          domain_name          = "usprodmkt-wordpress-1698395705.us-east-1.elb.amazonaws.com"
          origin_id            = "wordpress"
          connection_attempts  = 3
          connection_timeout   = 10
          custom_origin_config = {
            http_port                = 80
            https_port               = 443
            origin_keepalive_timeout = 5
            origin_protocol_policy   = "match-viewer"
            origin_read_timeout      = 30
            origin_ssl_protocols     = ["TLSv1.2"]
          }
        }]
      #default_cache_behavior attributes
      cached_methods                 = ["GET", "HEAD"]
      allowed_methods                = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
      target_origin_id               = "website-123371169.ap-southeast-1.elb.amazonaws.com"
      compress                       = true
      cache_policy_id                = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad" #Managed-CachingDisabled
      origin_request_policy_id       = "216adef6-5c7f-47e4-b989-5492eafa07d3"
      response_headers_policy_id     = "60669652-455b-4ae9-85a4-c4c02393f86c"
      viewer_protocol_policy         = "allow-all"
      smooth_streaming               = false
      min_ttl                        = 0
      default_ttl                    = 0
      max_ttl                        = 0
      #default_cache_behavior attributes ends
      // ...global attributes start...//
      retain_on_delete               = false
      http_version                   = "http2"
      enabled                        = true
      is_ipv6_enabled                = true
      price_class                    = "PriceClass_All"
      restriction_type               = "none" // ...global attributes ends...//
      # viewer_certificate attributes starts
      acm_certificate_arn            = "arn:aws:acm:us-east-1:393309748692:certificate/8c817c57-7a94-41d9-9fe3-9c858932f878"
      cloudfront_default_certificate = false
      minimum_protocol_version       = "TLSv1.2_2021"
      ssl_support_method             = "sni-only"
      # viewer_certificate attributes ends
      var_ordered_cache_behavior     = [
        {
          allowed_methods          = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
          cache_policy_id          = "${module.cdn.op_cache_policy_id["blog-custom-cache-policy"]}"
          cached_methods           = ["GET", "HEAD"]
          compress                 = true
          default_ttl              = 0
          max_ttl                  = 0
          min_ttl                  = 0
          origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
          path_pattern             = "/learn/*.css"
          smooth_streaming         = false
          target_origin_id         = "wordpress"
          viewer_protocol_policy   = "allow-all"
        },
        {
          allowed_methods          = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
          cache_policy_id          = "${module.cdn.op_cache_policy_id["blog-custom-cache-policy"]}"
          cached_methods           = ["GET", "HEAD"]
          compress                 = true
          default_ttl              = 0
          max_ttl                  = 0
          min_ttl                  = 0
          origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
          path_pattern             = "/learn/*.js"
          smooth_streaming         = false
          target_origin_id         = "wordpress"
          viewer_protocol_policy   = "allow-all"
        },
        {
          allowed_methods          = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
          cache_policy_id          = "${module.cdn.op_cache_policy_id["blog-custom-cache-policy"]}"
          cached_methods           = ["GET", "HEAD"]
          compress                 = true
          default_ttl              = 0
          max_ttl                  = 0
          min_ttl                  = 0
          origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
          path_pattern             = "/blog/*.css"
          smooth_streaming         = false
          target_origin_id         = "wordpress"
          viewer_protocol_policy   = "allow-all"
        }, {
          allowed_methods          = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
          cache_policy_id          = "${module.cdn.op_cache_policy_id["blog-custom-cache-policy"]}"
          cached_methods           = ["GET", "HEAD"]
          compress                 = true
          default_ttl              = 0
          max_ttl                  = 0
          min_ttl                  = 0
          origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
          path_pattern             = "/blog/*.js"
          smooth_streaming         = false
          target_origin_id         = "wordpress"
          viewer_protocol_policy   = "allow-all"
        },{
          allowed_methods             = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
          cache_policy_id             = "${module.cdn.op_cache_policy_id["blog-custom-cache-policy"]}"
          cached_methods              = ["GET", "HEAD"]
          compress                    = true
          default_ttl                 = 0
          lambda_function_association = {
            event_type   = "origin-response"
            include_body = false
            lambda_arn   = "${module.lambda.op_lambda_arn["asia-dev-blog-cache-html"]}"
          }
          max_ttl                  = 0
          min_ttl                  = 0
          origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
          path_pattern             = "/learn"
          smooth_streaming         = false
          target_origin_id         = "wordpress"
          viewer_protocol_policy   = "allow-all"
        },
        {
          allowed_methods             = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
          cache_policy_id             = "${module.cdn.op_cache_policy_id["blog-custom-cache-policy"]}"
          cached_methods              = ["GET", "HEAD"]
          compress                    = true
          default_ttl                 = 0
          lambda_function_association = {
            event_type   = "origin-response"
            include_body = false
            lambda_arn   = "${module.lambda.op_lambda_arn["asia-dev-blog-cache-html"]}"
          }
          max_ttl                  = 0
          min_ttl                  = 0
          origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
          path_pattern             = "/learn/*"
          smooth_streaming         = false
          target_origin_id         = "wordpress"
          viewer_protocol_policy   = "allow-all"
        },
        {
          allowed_methods             = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
          cache_policy_id             = "${module.cdn.op_cache_policy_id["blog-custom-cache-policy"]}"
          cached_methods              = ["GET", "HEAD"]
          compress                    = true
          default_ttl                 = 0
          lambda_function_association = {
            event_type   = "origin-response"
            include_body = false
            lambda_arn   = "${module.lambda.op_lambda_arn["asia-dev-blog-cache-html"]}"
          }
          max_ttl                  = 0
          min_ttl                  = 0
          origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
          path_pattern             = "/blog"
          smooth_streaming         = false
          target_origin_id         = "wordpress"
          viewer_protocol_policy   = "allow-all"
        },
        {
          allowed_methods             = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
          cache_policy_id             = "${module.cdn.op_cache_policy_id["blog-custom-cache-policy"]}"
          cached_methods              = ["GET", "HEAD"]
          compress                    = true
          default_ttl                 = 0
          lambda_function_association = {
            event_type   = "origin-response"
            include_body = false
            lambda_arn   = "${module.lambda.op_lambda_arn["asia-dev-blog-cache-html"]}"
          }
          max_ttl                  = 0
          min_ttl                  = 0
          origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
          path_pattern             = "/blog/*"
          smooth_streaming         = false
          target_origin_id         = "wordpress"
          viewer_protocol_policy   = "allow-all"
        },
        {
          allowed_methods          = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
          cache_policy_id          = "${module.cdn.op_cache_policy_id["blog-custom-cache-policy"]}"
          cached_methods           = ["GET", "HEAD"]
          compress                 = true
          default_ttl              = 0
          max_ttl                  = 0
          min_ttl                  = 0
          origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
          path_pattern             = "/static/*.css"
          smooth_streaming         = false
          target_origin_id         = "website-123371169.ap-southeast-1.elb.amazonaws.com"
          viewer_protocol_policy   = "allow-all"
        },
        {
          allowed_methods          = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
          cache_policy_id          = "${module.cdn.op_cache_policy_id["blog-custom-cache-policy"]}"
          cached_methods           = ["GET", "HEAD"]
          compress                 = true
          default_ttl              = 0
          max_ttl                  = 0
          min_ttl                  = 0
          origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
          path_pattern             = "/static/*.js"
          smooth_streaming         = false
          target_origin_id         = "website-123371169.ap-southeast-1.elb.amazonaws.com"
          viewer_protocol_policy   = "allow-all"
        }
      ]
    }
  }
  var_cdn_policy = {
    blog-custom-cache-policy = {
      default_ttl                                     = "86400"
      max_ttl                                         = "31536000"
      min_ttl                                         = "1"
          cookie_behavior               = "none"
          enable_accept_encoding_brotli = "true"
          enable_accept_encoding_gzip   = "true"
          header_behavior               = "none"
          query_string_behavior         = "all"
    }
  }
}
