
#### Scripts to generate an initial liquibase starting changeset from a set of schema defintions and role sql

#### Notes
  - provisions without chef
  - provisioning very fast.  39 secs first run,  3 secs subsequent - chef takes ~= 10 minutes


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


#### To extract src schemas definition and roles

```
# dump roles
sudo -u postgres pg_dumpall --roles-only > roles.sql

# dump schemas
sudo -u postgres pg_dump -d harvest -s  > schemas.sql


# load initial functions, ...
psql -h rds -d test -U imosadmin -f sql/useful.sql

```

------
#### TODO 

-- populate with test data and test geoserver works.
-- then pipeline.


