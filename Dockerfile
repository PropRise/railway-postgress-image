FROM pgduckdb/pgduckdb:15-main

USER root

# Install utilities to find the file
RUN apt-get update && apt-get install -y findutils

# Search for the postgresql.conf file and print its location
RUN find / -name postgresql.conf || echo "postgresql.conf not found"
