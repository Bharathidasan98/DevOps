#variable "var_domain_name" {
#  type = string
#}
#variable "var_domain_id" {
#  type = string
#}
#variable "var_enabled" {
#  type = bool
#}
#variable "var_ipv6_status" {
#  type = bool
#}
#variable "var_root_object" {
#  type = string
#}
#variable "var_comment" {
#  type = string
#}
#variable "var_cache_method_d" {
#  type = list(string)
#}
#variable "var_target_origin_id_d" {
#  type = string
#}
#variable "var_allowed_methods_d" {
#  type = list(string)
#}
#variable "var_event_type" {
#  type = string
#}
#
#variable "var_ordered_cache_behavior" {
#  type = list(object({
#    path_pattern     = optional(string, null)
#    allowed_methods  = optional(list(string), null)
#    cached_methods   = optional(list(string), null)
#    target_origin_id = optional(string, null)
#    query_string     = optional(string, null)
#    headers          = optional(list(string), null)
#  }))
#}
variable "var_cdn_cdn" {
  type = map(object({
    aliases             = list(string)
    origin = list(object({
      domain_name         = string
      origin_id           = string
      connection_attempts = number
      connection_timeout  = number
      s3_origin_config    = optional(object({
        origin_access_identity = optional(string, null)
      }), null)
      custom_origin_config = optional(object({
        http_port                = optional(number, null)
        https_port               = optional(number, null)
        origin_keepalive_timeout = optional(number, null)
        origin_protocol_policy   = optional(string, null)
        origin_read_timeout      = optional(number, null)
        origin_ssl_protocols     = optional(list(string), null)
      }), null)
    }))
    enabled                        = bool
    is_ipv6_enabled                = bool
    default_root_object            = string
    cached_methods                 = list(string)
    allowed_methods                = list(string)
    target_origin_id               = string
    cache_policy_id                = optional(string, null)
    compress                       = bool
    query_string                   = bool
    forward                        = string
    viewer_protocol_policy         = string
    min_ttl                        = number
    default_ttl                    = number
    max_ttl                        = number
    http_version                   = string
    origin_request_policy_id       = optional(string, null)
    price_class                    = string
    smooth_streaming               = bool
    retain_on_delete               = bool
    staging                        = bool
    restriction_type               = string
    locations                      = optional(list(string), null)
    acm_certificate_arn            = optional(string, null)
    cloudfront_default_certificate = bool
    minimum_protocol_version       = string
    ssl_support_method             = string
    var_ordered_cache_behavior = list(object({
      path_pattern     = optional(string, null)
      allowed_methods  = optional(list(string), null)
      cached_methods   = optional(list(string), null)
      target_origin_id = optional(string, null)
      query_string     = optional(string, null)
      headers          = optional(list(string), null)
      forward          = optional(string, null)
      #cache_policy_id  = optional(string, null)
      compress                 = optional(string, null)
      smooth_streaming         = optional(string, null)
      min_ttl                  = optional(number, null)
      default_ttl              = optional(number, null)
      max_ttl                  = optional(number, null)
      origin_request_policy_id = optional(string, null)
      viewer_protocol_policy   = optional(string, null)
      lambda_function_association = optional(object({
        event_type   = optional(string, null)
        include_body = optional(bool, null)
        lambda_arn   = optional(string, null)
      }), null)
    }))
  }))
}

#variable "var_cdn_policy" {
#  type = map(object({
#    #globalvariable
#    comment     = string
#    default_ttl = number
#    max_ttl     = number
#    min_ttl     = number
#    name        = string
#    #parameters_in_cache_key_and_forwarded_to_origin
#    parameters_in_cache_key_and_forwarded_to_origin = map(object({
#      cookie_behavior = string
#      cookies = optional(object({
#        items = list(string)
#      }), null)
#      enable_accept_encoding_brotli = bool
#      enable_accept_encoding_gzip   = bool
#      header_behavior               = string
#      headers = optional(object({
#        items = list(string)
#      }), null)
#      query_string_behavior = string
#      query_strings = optional(object({
#        items = list(string)
#      }), null)
#    }))
#  }))
#}

variable "var_cdn_policy" {
  type = map(object({
    #globalvariable
    comment     = optional(string)
    default_ttl = number
    max_ttl     = number
    min_ttl     = number
    #parameters_in_cache_key_and_forwarded_to_origin
      cookie_behavior = string
      var_cookies = optional(object({
        items = list(string)
      }), null)
      enable_accept_encoding_brotli = bool
      enable_accept_encoding_gzip   = bool
      header_behavior               = string
      var_headers = optional(object({
        items = list(string)
      }), null)
      query_string_behavior = string
      var_query_strings = optional(object({
        items = list(string)
      }), null)
    }))
}














