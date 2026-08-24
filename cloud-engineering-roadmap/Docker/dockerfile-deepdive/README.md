# Dockerfile Deep Dive & Security Hardening

This project demonstrates production-grade containerization practices focusing on non-root security context, minimal base images, and layer optimization.

## Key Implementations

* **Minimal Base Image**: Built using `python:3.11-slim` to reduce the attack surface and keep image size small.
* **Non-Root Execution**: Container execution runs under an unprivileged user (`appuser` with UID/GID `1001`), preventing potential container breakout attacks.
* **Layer Caching Optimization**: Environment variables and dependencies are staged before application code to leverage Docker build cache effectively.
* **Exec Form**: Commands use JSON array notation (`ENTRYPOINT`/`CMD`) to ensure Linux signals (`SIGTERM`, `SIGINT`) are handled directly by the application process.

## Verification & Output

```bash
# Verify user identity inside the running container
$ docker exec secure-app-test whoami
appuser

# Verify UID and GID mapping
$ docker exec secure-app-test id
uid=1001(appuser) gid=1001(appgroup) groups=1001(appgroup)

# Health verification
$ curl http://localhost:8080
Production Container is Running Securely as Non-Root!