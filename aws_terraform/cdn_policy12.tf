#tfer--08627262-05a9-4f76-9ded-b50ca2e3a84f = {
#  comment     = "Policy for Elemental MediaPackage Origin"
#  default_ttl = "86400"
#  max_ttl     = "31536000"
#  min_ttl     = "0"
#  name        = "Managed-Elemental-MediaPackage"
#  parameters_in_cache_key_and_forwarded_to_origin = {
#    default = {
#      cookie_behavior               = "none"
#      enable_accept_encoding_brotli = "false"
#      enable_accept_encoding_gzip   = "true"
#      header_behavior               = "whitelist"
#      headers = {
#        items = ["origin"]
#      }
#      query_string_behavior = "whitelist"
#      query_strings = {
#        items = ["aws.manifestfilter", "end", "m", "start"]
#      }
#    }
#  }
#}
#tfer--2e54312d-136d-493c-8eb9-b001f22f67d2 = {
#  comment     = "Policy for Amplify Origin"
#  default_ttl = "2"
#  max_ttl     = "600"
#  min_ttl     = "2"
#  name        = "Managed-Amplify"
#  parameters_in_cache_key_and_forwarded_to_origin = {
#    default = {
#      cookie_behavior               = "all"
#      enable_accept_encoding_brotli = "true"
#      enable_accept_encoding_gzip   = "true"
#      header_behavior               = "whitelist"
#      headers = {
#        items = ["Authorization", "CloudFront-Viewer-Country", "Host"]
#      }
#      query_string_behavior = "all"
#    }
#  }
#}
#tfer--4135ea2d-6df8-44a3-9df3-4b5a84be39ad = {
#  comment     = "Policy with caching disabled"
#  default_ttl = "0"
#  max_ttl     = "0"
#  min_ttl     = "0"
#  name        = "Managed-CachingDisabled"
#  parameters_in_cache_key_and_forwarded_to_origin = {
#    default = {
#      cookie_behavior               = "none"
#      enable_accept_encoding_brotli = "false"
#      enable_accept_encoding_gzip   = "false"
#      header_behavior               = "none"
#      query_string_behavior         = "none"
#    }
#  }
#}
#tfer--658327ea-f89d-4fab-a63d-7e88639e58f6 = {
#  comment     = "Policy with caching enabled. Supports Gzip and Brotli compression."
#  default_ttl = "86400"
#  max_ttl     = "31536000"
#  min_ttl     = "1"
#  name        = "Managed-CachingOptimized"
#  parameters_in_cache_key_and_forwarded_to_origin = {
#    default = {
#      cookie_behavior               = "none"
#      enable_accept_encoding_brotli = "true"
#      enable_accept_encoding_gzip   = "true"
#      header_behavior               = "none"
#      query_string_behavior         = "none"
#    }
#  }
#}
#tfer--6b0eaac0-c63f-4281-936c-ef8da7b7905e = {
#  default_ttl = "31536000"
#  max_ttl     = "31536000"
#  min_ttl     = "1"
#  name        = "expiry-365d"
#  parameters_in_cache_key_and_forwarded_to_origin = {
#    default = {
#      cookie_behavior               = "none"
#      enable_accept_encoding_brotli = "true"
#      enable_accept_encoding_gzip   = "true"
#      header_behavior               = "none"
#      query_string_behavior         = "none"
#    }
#  }
#}
#tfer--818ef4b9-2a75-448a-ad55-a9cc27be2d85 = {
#  default_ttl = "86400"
#  max_ttl     = "31536000"
#  min_ttl     = "1"
#  name        = "blog-custom-cache-policy"
#  parameters_in_cache_key_and_forwarded_to_origin = {
#    default = {
#      cookie_behavior               = "none"
#      enable_accept_encoding_brotli = "true"
#      enable_accept_encoding_gzip   = "true"
#      header_behavior               = "none"
#      query_string_behavior         = "all"
#    }
#  }
#}
#tfer--b2884449-e4de-46a7-ac36-70bc7f1ddd6d = {
#  comment     = "Default policy when compression is disabled"
#  default_ttl = "86400"
#  max_ttl     = "31536000"
#  min_ttl     = "1"
#  name        = "Managed-CachingOptimizedForUncompressedObjects"
#  parameters_in_cache_key_and_forwarded_to_origin = {
#    default = {
#      cookie_behavior               = "none"
#      enable_accept_encoding_brotli = "false"
#      enable_accept_encoding_gzip   = "false"
#      header_behavior               = "none"
#      query_string_behavior         = "none"
#    }
#  }
#}