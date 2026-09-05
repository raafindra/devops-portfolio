# ==============================================================================
# Microservice Module - Input Variables
# Defines schema and configurations required to provision a containerized service.
# ==============================================================================

variable "name" {
  type        = string
  description = "Unique identifier name for the container and service resources."
}

variable "image" {
  type        = string
  description = "Docker image repository and tag (e.g., 'nginx:alpine')."
}

variable "internal_port" {
  type        = number
  description = "Target listening port inside the container workload."
}

variable "external_port" {
  type        = number
  description = "Exposed host port. Set to 0 to retain strictly internal/private access."
  default     = 0
}

variable "network_name" {
  type        = string
  description = "Target bridge network name enabling secure container-to-container service discovery."
}

variable "env_vars" {
  type        = list(string)
  description = "List of environment variables injected into the container execution context."
  default     = []
}

variable "command" {
  type        = list(string)
  description = "Optional startup command/arguments passed to container process."
  default     = []
}