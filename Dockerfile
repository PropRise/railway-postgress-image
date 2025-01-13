FROM pgduckdb/pgduckdb:15-main

USER root

# Install utilities
RUN apt-get update && apt-get install -y findutils

# Start PostgreSQL in the background, then locate the config file
CMD ["sh", "-c", "/usr/lib/postgresql/15/bin/postgres -D /var/lib/postgresql/data & sleep 5 && find / -name postgresql.conf || echo 'postgresql.conf not found'"]
