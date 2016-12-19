#!/bin/bash

# eg. using,
# dump
# sudo -u postgres pg_dumpall --roles-only > roles.sql
# run using,
# psql -h rds -d initial -U imosadmin -f ~/imos/migration/dbrc/roles.sql

# make transactional
sed -i '1 s/.*/BEGIN;/' dbrc/roles.sql
sed -i '$ s/.*/ROLLBACK;/' dbrc/roles.sql


# set nosuperuser and noreplication by default, since imosadmin doesn't have permissions to do this in
# a subsequent 'alter role' statement
sed -i 's/CREATE ROLE \([^ ;]*\).*$/CREATE ROLE \1 NOSUPERUSER NOREPLICATION ;/g' dbrc/roles.sql

# remove nosuperuser and noreplication from alter role
sed -i 's/\(ALTER ROLE.*\)NOSUPERUSER\(.*\)/\1\2/g' dbrc/roles.sql
sed -i 's/\(ALTER ROLE.*\)NOREPLICATION\(.*\)/\1\2/g' dbrc/roles.sql


# delete postgres user creation
sed -i 's/CREATE ROLE postgres.*//g' dbrc/roles.sql
sed -i 's/ALTER ROLE postgres.*//g' dbrc/roles.sql


# remove replication user
sed -i 's/CREATE ROLE replication .*//g' dbrc/roles.sql
sed -i 's/ALTER ROLE replication.*//g' dbrc/roles.sql

# change grant delegation
sed -i 's/GRANTED BY postgres/GRANTED BY imosadmin/g' dbrc/roles.sql



#   OLD 
# sed    's/CREATE ROLE \([^ ;]*\).*$/CREATE ROLE \1 NOSUPERUSER NOREPLICATION NOCREATED NOCREATEROLE;/g' dbrc/roles.sql
# sed    's/\(ALTER ROLE.*\)NOSUPERUSER|NOREPLICATION\(.*\)/\1\2/g' dbrc/roles.sql

