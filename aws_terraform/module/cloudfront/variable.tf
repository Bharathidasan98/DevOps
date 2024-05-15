#ariable "var_domain_name" {
# type = string
#
#ariable "var_domain_id" {
# type = string
#
#ariable "var_enabled" {
# type = bool
#
#ariable "var_ipv6_status" {
# type    = bool
#
#ariable "var_root_object" {
# type = string
#
#variable "var_comment" {
#  type = string
#}
#ariable "var_cache_method_d" {
# type = list(string)
#
#ariable "var_target_origin_id_d" {
# type = string
#
#ariable "var_allowed_methods_d" {
# type = list(string)
#
#ariable "var_event_type" {
# type = string
#
#
#ariable "var_ordered_cache_behavior" {
# type = list(object({
#     path_pattern     = optional(string, null)
#     allowed_methods  = optional(list(string), null)
#     cached_methods   = optional(list(string), null)
#     target_origin_id = optional(string, null)
#       query_string = optional(string, null)
#       headers      = optional(list(string), null)
#   }))
#