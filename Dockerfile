FROM pgduckdb/pgduckdb:15-main

# Install PostGIS system dependencies
USER root
RUN apt-get update && apt-get install -y \
    postgis \
    postgresql-15-postgis-3 \
    postgresql-15-postgis-3-scripts \
    && rm -rf /var/lib/apt/lists/*

