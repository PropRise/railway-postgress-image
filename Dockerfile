FROM pgduckdb/pgduckdb:main-15

# Install PostGIS system dependencies
USER root
RUN apt-get update && apt-get install -y \
    postgis \
    postgresql-15-postgis-3 \
    postgresql-15-postgis-3-scripts \
    && rm -rf /var/lib/apt/lists/*

# Switch back to postgres user and create extensions
USER postgres
RUN echo "CREATE EXTENSION IF NOT EXISTS postgis;" >> /docker-entrypoint-initdb.d/init.sql
RUN echo "CREATE EXTENSION IF NOT EXISTS postgis_topology;" >> /docker-entrypoint-initdb.d/init.sql
