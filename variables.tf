#---------------------------------------------------------------
# GitHub
#---------------------------------------------------------------
variable "GITHUB_PAT" {
  type = string
  validation {
    condition     = length(var.GITHUB_PAT) > 1
    error_message = "No GITHUB_PAT env var set"
  }
}

variable "GITHUB_OWNER" {
  type = string
  validation {
    condition     = length(var.GITHUB_OWNER) > 1
    error_message = "No GITHUB_OWNER env var set"
  }
}

#---------------------------------------------------------------
# Resources: location, naming
#---------------------------------------------------------------

variable "location" {
  description = "Resources location"
  type        = string
  default     = "francecentral"
}

variable "name-core" {
  description = "The core part of resources naming"
  type        = string
  default     = "marthamain"
}

variable "suffix" {
  description = "The suffix part of resources naming"
  type        = string
  default     = "001"
}

#---------------------------------------------------------------
# IDs
#---------------------------------------------------------------

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

#---------------------------------------------------------------
# Tags
#---------------------------------------------------------------

variable "environment" {
  type        = string
  description = "The environment to be built"
  default     = "terraform"
}
