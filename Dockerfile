FROM pgduckdb/pgduckdb:15-main

# Install PostGIS and TimescaleDB system dependencies
USER root

# Install PostGIS and prepare for TimescaleDB
RUN apt-get update && apt-get install -y \
    postgis \
    postgresql-15-postgis-3 \
    postgresql-15-postgis-3-scripts \
    wget \
    gnupg2 \
    lsb-release \
    && wget --quiet -O - https://packagecloud.io/timescale/timescaledb/gpgkey | apt-key add - \
    && echo "deb https://packagecloud.io/timescale/timescaledb/debian/ $(lsb_release -c -s) main" > /etc/apt/sources.list.d/timescaledb.list \
    && apt-get update \
    && apt-get install -y timescaledb-2-postgresql-15 \
    && rm -rf /var/lib/apt/lists/*

