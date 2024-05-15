variable "var_domain_name" {
 type = string

variable "var_domain_id" {
 type = string

variable "var_enabled" {
 type = bool

variable "var_ipv6_status" {
 type    = bool

variable "var_root_object" {
 type = string

variable "var_comment" {
  type = string
}
variable "var_cache_method_d" {
 type = list(string)

variable "var_target_origin_id_d" {
 type = string

variable "var_allowed_methods_d" {
 type = list(string)

variable "var_event_type" {
 type = string


variable "var_ordered_cache_behavior" {
 type = list(object({
     path_pattern     = optional(string, null)
     allowed_methods  = optional(list(string), null)
     cached_methods   = optional(list(string), null)
     target_origin_id = optional(string, null)
       query_string = optional(string, null)
       headers      = optional(list(string), null)
   }))
