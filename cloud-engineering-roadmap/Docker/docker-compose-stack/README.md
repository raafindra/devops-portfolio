# Multi-Container Web & Cache Stack (Docker Compose)

This project demonstrates declarative multi-service orchestration using Docker Compose, covering service discovery, health-dependent startup sequences, and decoupled environment configurations.

## Architecture Overview

* **Web Service**: Custom Python HTTP application running as a non-root user (`appuser:1001`).
* **Cache Service**: In-memory Redis store (`redis:7.2-alpine`) backed by a dedicated named volume (`redis_data`) for state persistence.
* **Internal Networking**: Isolated user-defined bridge network (`internal_network`) facilitating DNS service discovery.
* **Resilience & Startup Order**: Enforced `depends_on` conditioned on Redis `service_healthy` status checks.
* **12-Factor Configuration**: Dynamic parameter injection via `.env` file (`APP_PORT`, `APP_ENV`, `REDIS_VERSION`).

## Verification & Output

```bash
# Verify running services and health status
$ docker compose ps
NAME          IMAGE              STATUS                   PORTS
redis_cache   redis:7.2-alpine   Up (healthy)             6379/tcp
web_app       custom-web-image   Up                       0.0.0.0:8080->8080/tcp

# Validate persistent hit counter via service discovery
$ curl http://localhost:8080
--- Multi-Container Stack (Docker Compose) ---
Environment : production
Connected to: redis_cache:6379
Page Views  : 3