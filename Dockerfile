# Use n8n as base image
FROM n8nio/n8n:latest

# Switch to root user for package installation
USER root

# Install additional dependencies
RUN apk add --no-cache \
    postgresql-client \
    curl

# Install n8n globally
RUN npm install -g n8n && \
    npm cache clean --force

# Create directory for n8n data
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n && \
    chmod 755 /home/node/.n8n

# Copy configuration files
COPY .env.production /home/node/.n8n/.env
COPY n8n/backup /backup
COPY start.sh /start.sh

# Set proper ownership and permissions
RUN chown -R node:node /home/node/.n8n /backup /start.sh && \
    chmod 600 /home/node/.n8n/.env && \
    chmod 755 /start.sh

# Switch back to node user
USER node

# Set environment variables
ENV NODE_ENV=production \
    N8N_DIAGNOSTICS_ENABLED=false \
    N8N_PERSONALIZATION_ENABLED=false \
    N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true \
    PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/lib/node_modules/n8n/bin:${PATH}"

# Set work directory
WORKDIR /home/node/.n8n

# Expose port
EXPOSE 5678

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:5678/healthz || exit 1

# Start n8n using our startup script
CMD ["/start.sh"]
