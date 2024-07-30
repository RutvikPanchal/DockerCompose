call cd ./mounts/tomcat-jdbc
call mvn clean package
call cd ./target
call copy "tomcat-jdbc.war" "../../"

call cd ../../

call curl -L -o postgresql.jar https://jdbc.postgresql.org/download/postgresql-42.6.0.jar
call curl -L -o mariadb.jar https://dlm.mariadb.com/2896635/Connectors/java/connector-java-2.7.9/mariadb-java-client-2.7.9.jar