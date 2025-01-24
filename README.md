# DockerCompose

A collection of docker-compose.yaml files to quickly spin up pods in Docker Desktop as a Sandbox Environment for Testing

<br/>

## Development Setup

1.) Install Docker Desktop

2.) Log in with Docker account

3.) Log in with Redhat account `docker login -u -p registry.redhat.io`

4.) `docker network create master`

5.) `docker compose up -d`

<br />

## Network Ports

**NOTE (Windows) :** run `netstat -ano` on a terminal to see all the in use ports

**NOTE:** host.docker.internal refers to "localhost" of the host machine

| Application | Ports ↓ |
| --- | --- |
| Microsoft SQL Server 2022 Standard Edition | 1322 |
| Kafka | 2181 <br /> 9000 <br /> 9092 |
| Grafana | 3000 |
| MariaDB | 3306 |
| Postgres | 4321 |
| Nexus | 8081 |
| RHPAM - Business Central | 8082 <br /> 8083 |
| RHPAM - Kie Server | 8084 |
| RHPAM - Kie Server - Customized | 8085 <br /> 8447 |
| JBoss Web Server | 8086 |
| JFrog Artifactory | 8087 |
| ActiveMQ | 8161 <br /> 61616 |
| Keycloak | 8480 |
| Apache Cassandra | 9042 |
| Prometheus | 9060 |
| Infinispan | 11222 |

## Apps
<br/>

1.) **ActiveMQ** - Basic Artemis ActiveMQ server

2.) **Apache Cassandra** - Basic Apache Cassandra Database server

3.) **Grafana** - Basic Grafana **Metrics** Dashboard

4.) **Infinispan** - An open-source in-memory database

5.) **JBoss Web Server** - Basic Jboss Web Server which depends on **Postgres**

6.) **JFrog Artifactory** - Basic Artifactory **Repository Manager** server

7.) **Kafka** - Single Node Kafka server with a single **Zookeeper** instance and a **Kafdrop UI** WebApp

8.) **Keycloak** - Open Source Identity and Access Management

9.) **MariaDB** - Basic MariaDB Database server

10.) **Microsoft SQL Server 2022 Standard Edition** - Basic Microsoft SQL Server 2022 Standard Edition

11.) **Nexus** - Basic Nexus **Repository Manager** server

12.) **Postgres** - Basic PostgreSQL **Database** server

13.) **Prometheus** - Basic Prometheus **Metrics** Collection server

14.) **RHPAM Business Central** - RedHat Process Automation Manager Business Central instance which allows users to develop and manage RHPAM Projects

15.) **RHPAM Kie Server** - RedHat Process Automation Manager Kie Server instance which depends on **AMQ Broker**, **Postgres** and **Nexus**

16.) **RHPAM Kie Server (Customized)** - Customized RedHat Process Automation Manager Kie Server instance which includes customizations injected as jar files and volume mounts (java projects which extend the api are included as well)

<br/>

## Development Notes
<br/>

```
1.) Docker uses the name of the parent directory of docker-compose.yaml as the name of compose project

2.) Use the Docker Desktop app to see all the set environment variables. It's located under Pod > Inspect Tab
    - It probably uses printenv to get a list of all the set environment variables
```