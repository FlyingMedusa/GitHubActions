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
