#!/bin/sh
cd ./mounts/jwt-generator
mvn clean package
cd ./target
cp "tomcat-jdbc.jar" "../../"