# Use n8n as base image since it's your main application
FROM n8nio/n8n:latest

# Install additional dependencies
RUN apt-get update && \
    apt-get install -y \
    postgresql-client \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create directory for n8n data
RUN mkdir -p /home/node/.n8n

# Copy configuration files
COPY .env.production /home/node/.n8n/.env
COPY n8n/backup /backup

# Set environment variables
ENV NODE_ENV=production
ENV N8N_DIAGNOSTICS_ENABLED=false
ENV N8N_PERSONALIZATION_ENABLED=false

# Set work directory
WORKDIR /home/node/.n8n

# Expose port
EXPOSE 5678

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:5678/healthz || exit 1

# Start n8n
CMD ["n8n", "start"]
