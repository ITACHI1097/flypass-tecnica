variable "access_key" {
  description = "access_key"
  type        = string
  sensitive   = true
}
variable "secret_key" {
  description = "secret_key"
  type        = string
  sensitive   = true
}

variable "namespace" {
  description = "namespace"
  type        = string
  sensitive   = true
}

variable "service_account_name" {
  description = "service_account_name"
  type        = string
  sensitive   = true
}