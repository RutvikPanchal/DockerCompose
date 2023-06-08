#!/bin/sh
cd ./mounts/jwt-generator
mvn clean package
cd ./target
cp "jwt-generator-1.0.0.jar" "../../"

cd ../../

cd ./kie-server-extension
mvn clean package -s settings.xml
cd ./target
cp "kie-server-extension-1.0.0.jar" "../../"