#!/bin/bash
set -e

# Path to the PostgreSQL configuration file
CONFIG_FILE="/var/lib/postgresql/data/pgdata/data/postgresql.conf"

# Check if the file exists before attempting to modify it
if [ -f "$CONFIG_FILE" ]; then
    echo "Appending 'shared_preload_libraries = timescaledb' to $CONFIG_FILE"
    echo "shared_preload_libraries = 'timescaledb'" >> "$CONFIG_FILE"
else
    echo "Configuration file not found at $CONFIG_FILE. Skipping modification."
fi
