#!/bin/sh
cd ./mounts/jwt-generator
mvn clean package
cd ./target
cp "tomcat-jdbc.war" "../../"

cd ../../
curl --output postgresql.jar https://jdbc.postgresql.org/download/postgresql-42.6.0.jar