#!/bin/sh
for file in /opt/app-root/src/postgresql-start/sql/*.sql; do
    echo Running $(basename ${file})
    psql -U $POSTGRESQL_USER -d $POSTGRESQL_DATABASE -f ${file}
done