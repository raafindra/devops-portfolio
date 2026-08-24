# 1. Use a minimal slim base image to reduce image size and minimize attack surface
FROM python:3.11-slim

# 2. Configure Python environment variables:
# - Prevent Python from writing .pyc files to disk
# - Force unbuffered stdout/stderr for real-time container logging
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    APP_PORT=8080

# 3. Set the application working directory
WORKDIR /app

# 4. Security Hardening: Create a dedicated non-root system group and user (UID/GID 1001)
RUN groupadd -g 1001 appgroup && \
    useradd -u 1001 -g appgroup -s /bin/sh -m appuser

# 5. Copy source code and transfer file ownership to the non-root user
COPY --chown=appuser:appgroup app.py .

# 6. Switch runtime execution context to non-root user
USER appuser

# 7. Document the exposed container port
EXPOSE 8080

# 8. Use exec form (JSON array) to ensure OS signals (SIGTERM, SIGINT) pass directly to the process
ENTRYPOINT ["python"]
CMD ["app.py"]