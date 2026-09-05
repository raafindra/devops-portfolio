# ==============================================================================
# Root Module - Local Values & Metadata Tagging
# Centralizes resource naming conventions and enterprise tracking tags.
# ==============================================================================

locals {
  # Standardized prefix for resource naming and namespace isolation
  prefix       = "${var.project_name}-${var.environment}"
  network_name = "${local.prefix}-net"

  # Common metadata tags adhering to infrastructure governance standards
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Tier        = "Multi-Tier-Microservices"
  }
}