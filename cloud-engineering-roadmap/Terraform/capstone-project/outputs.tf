# ==============================================================================
# Root Module - Operational Outputs
# Exposes external service endpoints and internal cluster discovery URLs.
# ==============================================================================

output "frontend_url" {
  description = "Public HTTP endpoint accessible from host interface."
  value       = module.frontend_web.endpoint
}

output "internal_network" {
  description = "Designated Docker network facilitating isolated service mesh traffic."
  value       = docker_network.private_network.name
}

output "backend_private_dns" {
  description = "Internal service discovery endpoint consumed strictly by frontend/mesh components."
  value       = "http://${module.backend_api.container_name}:5678"
}