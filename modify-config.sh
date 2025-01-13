#!/bin/bash
set -e

CONFIG_FILE="/var/lib/postgresql/data/pgdata/data/postgresql.conf"

# Check if the configuration file exists
if [ -f "$CONFIG_FILE" ]; then
    echo "Appending 'shared_preload_libraries = timescaledb' to $CONFIG_FILE"
    echo "shared_preload_libraries = 'timescaledb'" >> "$CONFIG_FILE"
    echo "Restarting PostgreSQL to apply changes..."
    pg_ctl restart
else
    echo "Configuration file not found. Skipping modification."
fi
