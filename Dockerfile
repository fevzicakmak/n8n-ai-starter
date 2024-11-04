FROM debian:bullseye-slim

# Install only the necessary system dependencies
RUN apt-get update && \
    apt-get install -y \
    postgresql-client \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set up volumes
VOLUME ["/home/node/.n8n", "/var/lib/postgresql/data", "/qdrant/storage", "/app/backend/data", "/meili_data", "/hoarder"]

# Expose ports
EXPOSE 3000 5432 5678 6333 7700 8080 9222

# Use a simple command to keep container running if needed
CMD ["tail", "-f", "/dev/null"]
