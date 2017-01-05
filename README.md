
#### Scripts to generate an initial liquibase starting changeset from a set of schema defintions and role sql



#### Usage


```
# drop all non-rds roles
psql -h rds  -U imosadmin -d postgres -f ./sql/useful.sql 
psql -h rds  -U imosadmin -d postgres -c 'select drop_non_rds_groups_and_roles()

# drop test database
psql -h rds -d initial -U imosadmin -c 'drop database test'

# create database test - using correct encoding, lctype etc
cat sql/create-test.sql | psql -h rds -d initial  -U imosadmin

# generate liquibase migrations from sql dumps in the sql dir 
./create-migrations.sh

# provision rds database with generated changeset
./provision.sh
```


#### Extracting src schemas definition and roles, talend functions etc

```
# dump roles
sudo -u postgres pg_dumpall --roles-only > roles.sql

# dump schemas
sudo -u postgres pg_dump -d harvest -s  > schemas.sql

# imos extension code from https://github.com/aodn/harvest_sql_library/blob/master/extension/imos--1.0.sql
sql/imos--1.0.sql

# initial supporting sql code,
psql -h rds -d test -U imosadmin -f sql/useful.sql

```

------
#### TODO 

-- populate with test data and test geoserver works.
-- then pipeline.


