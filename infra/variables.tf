variable "project_id" {
  description = "GCP / Firebase project ID."
  type        = string
}

variable "region" {
  description = "Default GCP region."
  type        = string
  default     = "us-central1"
}

variable "environment" {
  description = "Deployment environment (dev | staging | prod)."
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}

variable "billing_account" {
  description = "GCP billing account ID linked to the project."
  type        = string
  sensitive   = true
}
