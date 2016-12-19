#!/bin/bash

java -jar liquibase.jar update

#      --changeLogFile=db.changelog.xml \
#      --username=scott \
#      --password=tiger \
#      --url="jdbc:oracle:thin:@localhost:1521:oracle" \
#      --classpath=/usr/share/java/postgresql-jdbc3-9.2.jar  \
#      --driver=oracle.jdbc.OracleDriver \
