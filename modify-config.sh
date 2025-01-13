#!/bin/bash
set -e

CONFIG_FILE="/var/lib/postgresql/data/pgdata/data/postgresql.conf"

# Extensions that require preloading
REQUIRED_EXTENSIONS="timescaledb,pg_duckdb"

if [ -f "$CONFIG_FILE" ]; then
    echo "Appending required extensions to 'shared_preload_libraries' in $CONFIG_FILE"
    
    if grep -q "shared_preload_libraries" "$CONFIG_FILE"; then
        EXISTING_LIBRARIES=$(grep "shared_preload_libraries" "$CONFIG_FILE" | cut -d"=" -f2 | tr -d " '")
        NEW_LIBRARIES=$(echo "$EXISTING_LIBRARIES,$REQUIRED_EXTENSIONS" | awk -F, '{for (i=1; i<=NF; i++) if (!seen[$i]++) printf "%s,", $i}' | sed 's/,$//')
        sed -i "s/shared_preload_libraries.*/shared_preload_libraries = '$NEW_LIBRARIES'/" "$CONFIG_FILE"
        echo "Updated 'shared_preload_libraries' with: $NEW_LIBRARIES"
    else
        echo "shared_preload_libraries = '$REQUIRED_EXTENSIONS'" >> "$CONFIG_FILE"
        echo "Added 'shared_preload_libraries' with: $REQUIRED_EXTENSIONS"
    fi
else
    echo "Configuration file not found. Cannot apply changes."
fi
