variable "location" {
  description = "Azure region"
  type        = string
}

#---------------------------------------------------------------
# Resources naming
#---------------------------------------------------------------

variable "name-core" {
  description = "The core part of resources naming"
  type        = string
}

variable "suffix" {
  description = "The suffix part of resources naming"
  type        = string
}

#---------------------------------------------------------------
# IDs
#---------------------------------------------------------------

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}
