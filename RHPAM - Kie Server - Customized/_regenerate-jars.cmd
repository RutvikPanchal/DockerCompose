call cd ./mounts/jwt-generator
call mvn clean package
call cd ./target
call copy "jwt-generator-1.0.0.jar" "../../"

call cd ../../

call cd ./kie-server-extension
call mvn clean package -s settings.xml
call cd ./target
call copy "kie-server-extension-1.0.0.jar" "../../"