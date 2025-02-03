variable "location" {
  type        = string
  description = "Location where resources should be located."
}

variable "subscription_id" {
  type        = string
  description = "Subscription id."
}

variable "client_id" {
  type        = string
  description = "Client id."
}

variable "client_secret" {
  type        = string
  description = "Client secret."
  sensitive   = true
}

variable "tenant_id" {
  type        = string
  description = "Teanant id."
}
