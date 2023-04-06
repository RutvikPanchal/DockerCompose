# DockerCompose
A collection of docker-compose.yaml files to quickly spin up pods in Docker Desktop as a Sandbox Environment for Testing

<br/>

## Apps
<br/>

1.) **Artemis ActiveMQ Server** - Basic Artemis ActiveMQ server

2.) **Kafka** - Single Node Kafka server with a single **Zookeeper** instance and a **Kafdrop UI** WebApp

3.) **Nexus** - A basic Nexus **Repository Manager** server

4.) **Postgres** - A basic PostgreSQL **Database** server

5.) **RHPAM Kie Server** - A RedHat Process Automation Manager Kie Server Immutable instance which depends on ***AMQ Broker***, **Postgres** and **Nexus**

<br/>

## Development Notes
<br/>

```
1.) Use the Docker Desktop app to see all the set environment variables. It's located under Pod > Inspect Tab
    - It probably uses printenv to get a list of all the set environment variables
```