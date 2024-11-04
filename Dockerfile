# Use n8n as base image since it's your main application
FROM n8nio/n8n:latest

# Switch to root user for package installation
USER root

# Install additional dependencies using apk (Alpine package manager)
RUN apk add --no-cache \
    postgresql-client \
    curl

# Create directory for n8n data
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n

# Copy configuration files
COPY .env.production /home/node/.n8n/.env
COPY n8n/backup /backup

# Set proper ownership
RUN chown -R node:node /home/node/.n8n /backup

# Switch back to node user
USER node

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
