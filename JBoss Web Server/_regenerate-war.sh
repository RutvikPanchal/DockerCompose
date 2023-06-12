#!/bin/sh
cd ./mounts/jwt-generator
mvn clean package
cd ./target
cp "tomcat-jdbc.war" "../../"

cd ../../
curl -o postgresql.jar https://jdbc.postgresql.org/download/postgresql-42.6.0.jar
curl -o mariadb.jar https://dlm.mariadb.com/2896635/Connectors/java/connector-java-2.7.9/mariadb-java-client-2.7.9.jar