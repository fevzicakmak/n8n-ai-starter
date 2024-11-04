#!/bin/sh
set -e

echo "=== Starting n8n deployment ==="

# Print diagnostic information
echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"
echo "Directory contents:"
ls -la

# Function to check if PostgreSQL is ready
check_postgres() {
    echo "Checking PostgreSQL connection..."
    if pg_isready -h "$DB_POSTGRESDB_HOST" -U "$DB_POSTGRESDB_USER"; then
        echo "PostgreSQL connection successful"
        return 0
    else
        echo "PostgreSQL connection failed"
        return 1
    fi
}

# Wait for PostgreSQL with timeout
wait_for_postgres() {
    echo "Waiting for PostgreSQL..."
    for i in $(seq 1 30); do
        if check_postgres; then
            return 0
        fi
        echo "Attempt $i: Waiting for PostgreSQL to be ready..."
        sleep 5
    done
    echo "Error: PostgreSQL did not become ready in time"
    return 1
}

# Print non-sensitive environment variables
echo "=== Environment Variables ==="
env | grep -v "PASSWORD\|KEY\|SECRET" | sort

# Check n8n installation
echo "=== Checking n8n installation ==="
which n8n || echo "n8n not found in PATH"
n8n --version || echo "Failed to get n8n version"

# Check database connection
echo "=== Database Connection Check ==="
if ! wait_for_postgres; then
    echo "Failed to connect to database"
    exit 1
fi

# Ensure proper permissions
echo "=== Checking Permissions ==="
if [ ! -w "/home/node/.n8n" ]; then
    echo "Error: Cannot write to /home/node/.n8n"
    exit 1
fi

echo "=== Starting n8n ==="
exec n8n start --debug
