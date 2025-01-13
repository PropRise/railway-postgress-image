FROM pgduckdb/pgduckdb:15-main

# Install PostGIS and TimescaleDB system dependencies
USER root
RUN apt-get update && apt-get install -y \
    postgis \
    postgresql-15-postgis-3 \
    postgresql-15-postgis-3-scripts \
    timescaledb-2-postgresql-15 \
    && rm -rf /var/lib/apt/lists/*

