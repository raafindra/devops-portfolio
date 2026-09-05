# PaySecure: Multi-Tier Microservices Infrastructure via Terraform

[![Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?style=flat&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Docker](https://img.shields.io/badge/Docker-%230db7ed.svg?style=flat&logo=docker&logoColor=white)](https://www.docker.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

An enterprise-grade Infrastructure as Code (IaC) implementation demonstrating modular architecture, isolated container networking, conditional port exposure, and private service discovery using HashiCorp Terraform and Docker.

---

## 🏛️ Architecture Overview

The infrastructure isolates the application tiers to implement defense-in-depth security principles:
[ Host Port: 8080 ]
                          │
                          ▼
              ┌───────────────────────┐
              │   paysecure-web-dev   │             (Edge / Public Tier - Nginx)
              └───────────┬───────────┘
                          │
Docker Bridge Network     │ Internal Service Discovery
"paysecure-dev-net"       │ http://paysecure-api-dev:5678
                          ▼
                ┌───────────────────────┐
                │   paysecure-api-dev   │                 (Private Backend API)
                └───────────────────────┘
                [ Port: 0 (Private) ]


* **Public Edge Tier (`paysecure-web-dev`):** Publicly accessible through host port mapping (`8080:80`).
* **Private Compute Tier (`paysecure-api-dev`):** Bound strictly to the private bridge network. Zero host ports exposed (`external_port = 0`), mitigating external attack vectors.
* **Internal Service Discovery:** Microservices communicate using deterministic container names resolved by Docker's embedded internal DNS server.

---

## 🚀 Key Engineering Highlights

* **DRY Modular Design:** Core container provisioning logic is abstracted into a reusable child module (`modules/microservice`), supporting multiple microservice topologies via parameterization.
* **Conditional Dynamic Port Exposure:** Leverages Terraform `dynamic "ports"` blocks and ternary conditions to provision host port bindings only when `external_port > 0`.
* **State Immutability & Pinning:** References engine-generated `image_id` cryptographic digests rather than volatile image tags, ensuring deterministic deployments and explicit resource ordering.
* **Input Validation & Governance:** Employs variable validation guardrails enforcing strict environment namespace controls (`dev`, `staging`, `prod`).

---

## 📂 Repository Structure

```text
.
├── main.tf                 # Root orchestration: provisions network and invokes modules
├── variables.tf            # Global input variables and validation constraints
├── locals.tf               # Centralized metadata tags and resource naming conventions
├── outputs.tf              # Operational outputs: endpoints, network identifiers, internal DNS
├── terraform.tfvars        # Environment-specific configuration parameters
└── modules/
    └── microservice/       # Reusable child module
        ├── main.tf         # Underlying image pull and container deployment logic
        ├── variables.tf    # Module contracts and parameter schemas
        └── outputs.tf      # Exported container properties and dynamic endpoints

📋 Prerequisites
Terraform: >= 1.5.0

Docker Engine: >= 24.0.0

Operating System: Linux (Ubuntu 22.04+ / RHEL), macOS, or WSL2

🛠️ Step-by-Step Deployment
1. Clone & Initialize
Clone the repository and initialize the working directory to download the required provider plugins and register child modules:

Bash
git clone [https://github.com/](https://github.com/)<your-username>/paysecure-terraform-iac.git
cd paysecure-terraform-iac
terraform init

2. Code Quality & Syntax Formatting
Validate configuration integrity and enforce canonical HCL formatting:

Bash
terraform fmt -recursive
terraform validate

3. Execution Plan Inspection
Generate and review the declarative execution plan:

Bash
terraform plan
4. Provision Infrastructure
Apply the deployment plan:

Bash
terraform apply -auto-approve
🧪 Verification & Testing
1. Verify Operational Outputs
Inspect the dynamic endpoints computed at runtime:

Bash
terraform output
2. Public Edge Verification
Confirm the public Nginx web proxy responds over port 8080:

Bash
curl -I http://localhost:8080
Expected Response: HTTP/1.1 200 OK

3. Security Boundary Verification (Zero Host Exposure)
Verify that direct host access to the backend service is blocked:

Bash
curl --connect-timeout 2 http://localhost:5678
Expected Response: Failed to connect to localhost port 5678: Connection refused

4. Inter-Service Communication via Internal DNS
Verify that the frontend container communicates with the internal API through private service discovery:

Bash
docker exec -it paysecure-web-dev wget -qO- http://paysecure-api-dev:5678
Expected Response: Hello from PaySecure Internal API!

🧹 Teardown & Resource Cleanup
To avoid configuration drift and release host resources:

Bash
terraform destroy -auto-approve

👤 Author
Portfolio: Raafindra Wahyu Pratama / https://github.com/raafindra/devops-portfolio/tree/main/cloud-engineering-roadmap

Role: Cloud / DevOps Engineer

Certifications: AWS Certified Solutions Architect Associate (In Progress) | 
HashiCorp Certified: Terraform Associate (In Progress)