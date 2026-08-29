# PaySecure Cloud Platform - Kubernetes Manifests

Production-grade Kubernetes deployment architecture for a high-availability Fintech Payment Gateway simulation.

## Architecture Highlights
- **Namespace Isolation:** Multi-tier resource grouping (\`paysecure-prod\`).
- **Decoupled Configuration:** ConfigMaps for non-sensitive properties & Base64-encoded Secrets for DB credentials.
- **Stateful Persistence:** PostgreSQL deployment backed by PersistentVolumeClaim (PVC).
- **Zero-Downtime & High Availability:** Multi-replica API deployment with \`startupProbe\`, \`readinessProbe\`, and \`livenessProbe\`.
- **L7 Routing:** Traefik Ingress Controller for domain-based routing (\`api.paysecure.local\`).

## Deployment Structure
\`\`\`text
├── 00-namespace.yaml
├── 01-configs.yaml
├── 02-database.yaml
├── 03-backend.yaml
└── 04-ingress.yaml
\`\`\`

## Quick Start
\`\`\`bash
# Apply all manifests to Kubernetes
kubectl apply -f .

# Verify deployment
kubectl get all,pvc,ingress -n paysecure-prod
\`\`\`