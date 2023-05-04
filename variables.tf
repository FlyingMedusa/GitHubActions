variable "location" {
  description = "Resources location"
  type        = string
  default     = "francecentral"
}

variable "name-core" {
  description = "The core part of resources naming"
  type        = string
  default     = "ghactionstryout"
}

variable "suffix" {
  description = "The suffix part of resources naming"
  type        = string
  default     = "001"
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
  default     = "075ddcce-4e47-4d33-843f-c6b7fbc0ba52"
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = "ac10c819-2836-4539-a08d-cf5c42a71d7a"
}
