#!/bin/bash

read -d '' header <<EOF
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<databaseChangeLog
xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-2.0.xsd">
EOF

read -d '' footer <<EOF
</databaseChangeLog>
EOF

cat > ./changelog.xml <<- EOF
$header
  <include file="migrations/db.roles.xml"/>
  <include file="migrations/db.functions.xml"/>
  <include file="migrations/db.schemas.xml"/>
$footer
EOF

cat > ./migrations/db.roles.xml <<- EOF
$header
  <changeSet author="julian" id="db.roles-0001">
    <sql>
      $( awk -f awk/extract-roles.awk sql/roles.sql )
    </sql>
	</changeSet>
$footer
EOF


cat > ./migrations/db.functions.xml <<- EOF
$header

  <changeSet author="julian" id="myextension-0001">
    <sql>
      create extension postgis ; 
    </sql>
	</changeSet>


  <changeSet author="julian" id="db.functions-0001">
    <sql splitStatements="false" >
      <![CDATA[
        $( awk -f awk/extract-functions.awk sql/imos--1.0.sql )
      ]]>
    </sql>
	</changeSet>
$footer
EOF


cat > ./migrations/db.schemas.xml <<- EOF
$header
  <changeSet author="julian" id="db.schemas-0001">
    <sql>
      $( awk -f awk/extract-schemas.awk sql/schemas.sql )
    </sql>
	</changeSet>
$footer
EOF


