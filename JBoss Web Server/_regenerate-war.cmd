call cd ./mounts/tomcat-jdbc
call mvn clean package
call cd ./target
call copy "tomcat-jdbc.war" "../../"