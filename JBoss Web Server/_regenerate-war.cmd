call cd ./mounts/tomcat-jdbc
call mvn clean package
call cd ./target
call copy "tomcat-jdbc.war" "../../"

call cd ../../
call curl --output postgresql.jar https://jdbc.postgresql.org/download/postgresql-42.6.0.jar