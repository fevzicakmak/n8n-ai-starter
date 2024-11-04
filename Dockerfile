FROM n8nio/n8n:latest

USER root

# Install essential dependencies
RUN apk add --no-cache curl

# Create and set permissions for n8n directory
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n && \
    chmod 755 /home/node/.n8n

# Copy configuration files
COPY --chown=node:node .env.production /home/node/.n8n/.env

USER node
WORKDIR /home/node/.n8n

# Set environment variables
ENV NODE_ENV=production \
    N8N_DIAGNOSTICS_ENABLED=false \
    N8N_PERSONALIZATION_ENABLED=false \
    N8N_LOG_LEVEL=debug \
    PATH="/usr/local/lib/node_modules/n8n/bin:${PATH}"

# Expose port
EXPOSE 5678

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:5678/healthz || exit 1

# Start n8n with debug logging
CMD ["sh", "-c", "n8n start --debug"]
