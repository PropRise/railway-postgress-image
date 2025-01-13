# Base image with PostgreSQL
FROM pgduckdb/pgduckdb:15-main

# Switch to root for installation
USER root

# Install PostGIS and TimescaleDB dependencies
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

# Copy the dynamic config script
COPY modify-config.sh /docker-entrypoint-initdb.d/modify-config.sh
RUN chmod +x /docker-entrypoint-initdb.d/modify-config.sh

# Switch to postgres user
USER postgres

# Override the entrypoint with a wrapper script
COPY wrapper.sh /usr/local/bin/wrapper.sh
RUN chmod +x /usr/local/bin/wrapper.sh

# Set the entrypoint to the wrapper script
ENTRYPOINT ["wrapper.sh"]

# Start PostgreSQL with the default port
CMD ["postgres"]
