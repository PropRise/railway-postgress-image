FROM postgres:15

# Install build dependencies
USER root
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    postgresql-server-dev-15 \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# Clone and build pg_duckdb
RUN git clone --recursive https://github.com/duckdb/pg_duckdb.git \
    && cd pg_duckdb \
    && make install

# Add pg_duckdb to shared preload libraries
RUN echo "shared_preload_libraries = 'pg_duckdb'" >> /usr/share/postgresql/postgresql.conf.sample

