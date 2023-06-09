# DockerCompose

A collection of docker-compose.yaml files to quickly spin up pods in Docker Desktop as a Sandbox Environment for Testing

<br/>

## Development Setup

1.) Install Docker Desktop

2.) Log in with Docker account

3.) Log in with Redhat account `docker login -u -p registry.redhat.io`

4.) `docker network create master`

<br />

## Network Ports

**NOTE (Windows) :** run `netstat -ano` on a terminal to see all the in use ports

| Application | Ports ↓ |
| --- | --- |
| Kafka | 2181 <br /> 9000 <br /> 9092 |
| Postgres | 4321 |
| Nexus | 8081 |
| RHPAM - Business Central | 8082 |
| RHPAM - Kie Server | 8083 |
| RHPAM - Kie Server - Customized | 8084 <br /> 8447 |
| JBoss Web Server | 8086 |
| ActiveMQ | 8161 <br /> 61616 |

## Apps
<br/>

1.) **ActiveMQ Artemis** - Basic Artemis ActiveMQ server

2.) **JBoss Web Server** - A Basic Jboss Web Server

2.) **Kafka** - Single Node Kafka server with a single **Zookeeper** instance and a **Kafdrop UI** WebApp

3.) **Nexus** - A basic Nexus **Repository Manager** server

4.) **Postgres** - A basic PostgreSQL **Database** server

5.) **RHPAM Business Central** - A RedHat Process Automation Manager Business Central instance which allows users to develop and manage RHPAM Projects

6.) **RHPAM Kie Server** - A RedHat Process Automation Manager Kie Server instance which depends on **AMQ Broker**, **Postgres** and **Nexus**

7.) **RHPAM Kie Server (Customized)** - A Customized RedHat Process Automation Manager Kie Server instance which includes customizations injected as jar files and volume mounts (java projects which extend the api are included as well)

<br/>

## Development Notes
<br/>

```
1.) Docker uses the name of the parent directory of docker-compose.yaml as the name of compose project

2.) Use the Docker Desktop app to see all the set environment variables. It's located under Pod > Inspect Tab
    - It probably uses printenv to get a list of all the set environment variables
```