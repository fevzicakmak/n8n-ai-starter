FROM node:21 AS base

WORKDIR /app

# Install base dependencies
RUN apt-get update && \
    apt-get install -y \
    postgresql-client \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy application code
COPY . .

# Install node packages
RUN npm install

# Build the application
RUN npm run build

# Set up volumes
VOLUME ["/home/node/.n8n", "/var/lib/postgresql/data", "/qdrant/storage", "/app/backend/data", "/meili_data", "/hoarder"]

# Expose ports
EXPOSE 3000 5432 5678 6333 7700 8080 9222

# Start the application
CMD ["npm", "start"]
