variable "spn_name" {
  description = "Name of the Service Principal"
  type        = string
}   

variable "subscription_id" {
  description = "Azure Subscription ID where the Service Principal will be assigned the role"
  type        = string
}   

variable "secret_expiry" {
  description = "Expiration date for the Service Principal's client secret (e.g., 2025-12-31T23:59:59Z)"
  type        = string
  default = "2026-12-31T00:00:00Z"
}