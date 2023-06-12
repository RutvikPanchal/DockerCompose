## 1.3.0
- Postgres
  - Added scripts to execute sql queries when database starts up
- Added JBoss Web Server
  - added a simple jdbc test java webapp
  - added database config
- Added Apache Cassandra

## 1.2.2
- RHPAM - Kie Server - Customized
  - added _regenerate-jars shell script to work with Linux/MacOS
  - fixed EOL errors
  - fixed scripts not being executed (added chmod +x) in Linux/MacOS

## 1.2.1
- RHPAM - Kie Server - Customized
  - added a script to generate jars from the included java projects
  - bug fixes & fine tuning

## 1.2.0
- Added RHPAM - Kie Server - Customized docker-compose
  - configured a HTTPS endpoint using a self signed certificate (sandbox.jks)
  - added kie-server-extension jar file and project which adds a custom kie-server endpoint with user-defined behavior
  - added jwt_generator project to generate jwt tokens using sandbox.jks cert for testing the now secured kie-server
  - added kie-server lifecycle scripts (.sh files) to configure the jboss-eap server on startup to only let authorized users access the kie-server
  - added a CustomRoleDecoder (class file included in jwt-generator.jar, configured as a jboss eap module, refer postconfigure.sh script) for rbac
  - added a modified web.xml which tells the jboss-eap server to secure the kie-server deployment

## 1.1.0
- Added RHPAM - Business Central docker-compose
- updated RHPAM - Kie Server from 7.10.1 to 7.13.2

## 1.0.0
- Master commit