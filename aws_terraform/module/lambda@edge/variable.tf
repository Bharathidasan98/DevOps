#----------------------------------------------version-1
#variable "var_lambda_function" {
#  type = map(object({
#    filename         = string
#    function_name    = string
#    role             = string
#    handler          = string
#   # source_code_hash = optional(string, null)
#    runtime          = string
#  }))
#}
#variable "var_archive_file" {
#  type = map(object({
#  source_file      = string
#  output_path      = string
#  }))
#}

#---------------------------------------------version-0
#variable "var_source_file" {
#  type = string
#}
#variable "var_output_path" {
#  type = string
##}
#variable "var_lambda_role" {
#  type = string
#}
#variable "var_lambda_rolename" {
# type = string
#  }


#new version
variable "var_lambda_function" {
  type = map(object({
  filename      = optional(string, null)
  role          = string
  handler       = optional(string, null)
  runtime = string
  publish = bool
  }))
}
variable "var_archive_file" {
  type = map(object({
  source_file      = string
  output_path      = string
  }))
}