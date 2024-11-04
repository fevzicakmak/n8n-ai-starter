FROM n8nio/n8n:latest

USER root

# Install essential dependencies
RUN apk add --no-cache \
    curl \
    postgresql-client

# Set up n8n directory
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n && \
    chmod 755 /home/node/.n8n

# Copy and set up entrypoint script
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh && \
    chown node:node /docker-entrypoint.sh

# Copy environment file
COPY --chown=node:node .env.production /home/node/.n8n/.env

# Switch to node user
USER node
WORKDIR /home/node/.n8n

# Set environment variables
ENV NODE_ENV=production \
    N8N_LOG_LEVEL=debug \
    N8N_DIAGNOSTICS_ENABLED=false \
    N8N_PERSONALIZATION_ENABLED=false \
    PATH="/usr/local/lib/node_modules/n8n/bin:${PATH}"

# Expose port
EXPOSE 5678

# Health check with increased timeouts
HEALTHCHECK --interval=30s --timeout=30s --start-period=120s --retries=5 \
    CMD curl -f http://localhost:5678/healthz || exit 1

# Start n8n using our entrypoint script
ENTRYPOINT ["/docker-entrypoint.sh"]
