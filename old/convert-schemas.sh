#!/bin/bash

input=dbrc/schemas.sql
output=dbrc/schemas.out.sql

# dump created with 
# sudo -u postgres pg_dump -d harvest -s  > schemas.sql
# 
# TODO - could chain everything together....  with -e and '\'

# issue 
cp $input $output

# make transactional
sed -i '1 s/.*/BEGIN;/' $output
sed -i '$ s/.*/ROLLBACK;/' $output


# delete chef schemas
sed -i 's/CREATE SCHEMA chef.*//' $output
sed -i 's/ALTER SCHEMA chef.*//' $output


# other postgres owned schemas, get owner changed to imosadmin
# abos, parameters_mapping, report_test
sed -i 's/ALTER SCHEMA \([^ ].*\) OWNER TO postgres/ALTER SCHEMA \1 OWNER TO imosadmin/' $output


# imosadmin doesn't have permissions to add a comment on an extension
sed -i 's/COMMENT ON EXTENSION .*//' $output


# delete imos extension
sed -i 's/CREATE EXTENSION IF NOT EXISTS imos.*//' $output
sed -i 's/COMMENT ON EXTENSION imos.*//' $output


# then we have all the create tables/functions 




# awk 'BEGIN { FS="\n"; RS="CREATE |ALTER |COMMENT |SET " } { print $1 ;print $1 }' dbrc/schemas.sql  | less




