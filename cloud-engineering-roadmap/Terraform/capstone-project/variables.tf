# ==============================================================================
# Root Module - Input Variables & Guardrails
# Global configuration variables enforcing environment integrity.
# ==============================================================================

variable "environment" {
  type        = string
  description = "Deployment target environment stage."
  default     = "dev"

  # Validation Guardrail: Enforce standardized environment namespaces
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Invalid environment specified. Allowed values: 'dev', 'staging', or 'prod'."
  }
}

variable "project_name" {
  type        = string
  description = "Global prefix applied to all infrastructure resource naming."
  default     = "paysecure"
}