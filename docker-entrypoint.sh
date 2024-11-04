#!/bin/sh
set -e

echo "Starting n8n deployment..."

# Function to check if PostgreSQL is ready
wait_for_postgres() {
    echo "Waiting for PostgreSQL to be ready..."
    max_retries=30
    retry_count=0

    while [ $retry_count -lt $max_retries ]; do
        if pg_isready -h "$DB_POSTGRESDB_HOST" -U "$DB_POSTGRESDB_USER" > /dev/null 2>&1; then
            echo "PostgreSQL is ready!"
            return 0
        fi

        retry_count=$((retry_count+1))
        echo "Waiting for PostgreSQL... (Attempt $retry_count/$max_retries)"
        sleep 2
    done

    echo "Error: PostgreSQL did not become ready in time"
    return 1
}

# Print environment for debugging (excluding sensitive values)
echo "Checking environment..."
env | grep -v "PASSWORD\|KEY\|SECRET" | sort

# Wait for PostgreSQL
wait_for_postgres

echo "Starting n8n..."
exec n8n start --debug
