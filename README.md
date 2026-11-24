# Oxvenia CEO Test Repository

Sample Terraform, Kubernetes, and Dockerfile configurations prepared for testing **Oxvenia IaC** (`invinciblemax0@gmail.com` / `Hobby` test flow) end-to-end:

1. **Checkov Security Scan** across Terraform (`.tf`), Kubernetes (`.yaml`), and `Dockerfile`
2. **Findings & Remediation PRs** generated from infrastructure misconfigurations
3. **SOC 2 Supporting Evidence** export after scanning and reviewing fixes

## Included Files
- `infra/main.tf` — Intentional Terraform security findings (public S3 bucket without encryption/versioning, open SSH `0.0.0.0/0` security group, unencrypted RDS instance) for realistic scan & remediation PR testing.
- `k8s/deployment.yaml` — Sample Kubernetes deployment manifest for multi-framework scanning.
- `Dockerfile` — Sample container build definition using a non-root user.
