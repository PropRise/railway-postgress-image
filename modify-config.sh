#!/bin/bash
set -e

CONFIG_FILE="/var/lib/postgresql/data/pgdata/data/postgresql.conf"

if [ -f "$CONFIG_FILE" ]; then
    echo "Appending 'shared_preload_libraries = timescaledb,pg_duckdb' to $CONFIG_FILE"
    if ! grep -q "shared_preload_libraries = 'timescaledb,pg_duckdb'" "$CONFIG_FILE"; then
        echo "shared_preload_libraries = 'timescaledb,pg_duckdb'" >> "$CONFIG_FILE"
        
        echo "Configuration updated. The database needs to be restarted for changes to take effect."
    else
        echo "shared_preload_libraries already configured."
    fi
else
    echo "Configuration file not found. Cannot apply changes."
fi
