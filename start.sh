#!/bin/sh
set -e

echo "Starting n8n with verbose logging..."
echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"
echo "Checking directory permissions..."
ls -la /home/node/.n8n

echo "Checking environment variables..."
env | grep -E "N8N_|DB_" | cut -d= -f1

echo "Starting n8n..."
exec /usr/local/lib/node_modules/n8n/bin/n8n start --verbose
