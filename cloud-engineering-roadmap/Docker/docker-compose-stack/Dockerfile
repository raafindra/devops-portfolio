FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN groupadd -g 1001 appgroup && \
    useradd -u 1001 -g appgroup -s /bin/sh -m appuser

COPY --chown=appuser:appgroup app.py .

USER appuser

EXPOSE 8080

ENTRYPOINT ["python"]
CMD ["app.py"]