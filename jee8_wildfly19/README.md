# Java/Jakarta EE8
Celovite platfome (Windows Zip)

Priporočeno::
- [jee8_complete.zip](https://drive.google.com/file/d/17eaRgtX3xyCR39o6S38pIQxL8qVl-FMl/view?usp=sharing) ~1.21GB [Info](#jee8_complete) [Build log](#BuildLog)

Ostale datoteke:

- [jee8_eclipse_wildfly_pqsql.zip](https://drive.google.com/file/d/1B7RGmexwOqGShq0WL0AI7EK8txbP4MAt/view?usp=sharing) ~1.02GB [Info](#jee8_eclipse_wildfly_pqsql) [Build log](#BuildLog)



# jee8_complete
[download](https://drive.google.com/file/d/17eaRgtX3xyCR39o6S38pIQxL8qVl-FMl/view?usp=sharing) ~1.21GB

### Vsebina paketa:
- JDK 1.8.0
- Eclipse 2020.03
- Wildfly 19.0.0
- Postgresql 12.2
- PgAdmin 4
- MySql 8
- Demo projekt (Eclipse - run, IntelliJ - testirano na IntelliJIdea2019.3.4 Ultimate - open-run)

### Navodila:

- Razpakirati v `C:\jee8`
- WildFly port: 28080
- WildFly admin: u:user, p:user
- Wildfly app user: u:guest, p:guest; role: guest
- Postgresql: u:postgres, p:postgres
- Mysql: u:root, p:root
- DS JNDI: java:jboss/datasources/mysqlds --> mysql (testdb)
- DS JNDI: java:jboss/datasources/postgresds --> postgresql (testdb)
- Queue JNDI: jms/queue/test
- Topic JNDI: jms/topic/test


# jee8_eclipse_wildfly_pqsql
[download](https://drive.google.com/file/d/1B7RGmexwOqGShq0WL0AI7EK8txbP4MAt/view?usp=sharing) ~1.02GB

### Vsebina paketa:
- JDK 1.8.0
- Eclipse 2020.03
- Wildfly 19.0.0
- Postgresql 12.2
- PgAdmin 4
- Demo projekt (Eclipse - run, IntelliJ - testirano na IntelliJIdea2019.3.4 Ultimate - open-run)

### Navodila:

- Razpakirati v `C:\jee8`
- WildFly port: 28080
- WildFly admin: u:user, p:user
- Wildfly app user: u:guest, p:guest; role: guest
- Postgresql: u:postgres, p:postgres
- DS JNDI: java:jboss/datasources/mysqlds --> mysql (127.0.0.1:3306/testdb; u:root, p:root)
- DS JNDI: java:jboss/datasources/postgresds --> postgresql (testdb)
- Queue JNDI: jms/queue/test
- Topic JNDI: jms/topic/test


# BuildLog

POSTGRESQL
==========
[postgresql-12.2-2-windows-x64-binaries.zip](https://www.enterprisedb.com/download-postgresql-binaries)

[postgresql-42.2.12.jar](https://jdbc.postgresql.org/download.html)

```
C:\jee8\pgsql\bin\initdb -D C:\jee8\pgsql_data -U postgres -W -E UTF8 -A scram-sha-256
p:postgres
```

Zagon:
```
C:\jee8\pgsql\bin\pg_ctl -D C:\jee8\pgsql_data -l C:\jee8\pgsql_data\log.txt start
```

Ustavitev:
```
C:\jee8\pgsql\bin\pg_ctl -D C:\jee8\pgsql_data stop
```

CLI odjemalec:
```
C:\jee8\pgsql\bin\psql.exe -U postgres
```

```
CREATE DATABASE testdb;
\l
\c testdb;
CREATE TABLE COMPANY(
   ID INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   AGE            INT     NOT NULL,
   ADDRESS        CHAR(50),
   SALARY         REAL
);
\dt
\d company
\q
```

PgAdmin4 zagon:
```
"C:\jee8\pgsql\pgAdmin 4\bin\pgAdmin4.exe"
```
[http://127.0.0.1:60865/browser/](http://127.0.0.1:60865/browser/)

MYSQL
=====
[VC_redist.x64.exe](https://support.microsoft.com/en-us/help/2977003/the-latest-supported-visual-c-downloads)

[mysql-8.0.19-winx64.zip](https://dev.mysql.com/downloads/mysql/)

[mysql-connector-java-8.0.19.zip](https://dev.mysql.com/downloads/connector/j/)

my.ini:
```
[mysqld]
basedir=C:/jee8/mysql-8.0.19-winx64
datadir=C:/jee8/mysql-8.0.19-winx64/data
default-time-zone='+01:00'
```

```
C:\jee8\mysql-8.0.19-winx64\bin\mysqld --defaults-file=C:\jee8\mysql-8.0.19-winx64\my.ini --initialize-insecure
C:\jee8\mysql-8.0.19-winx64\bin\mysqld --defaults-file=C:\jee8\mysql-8.0.19-winx64\my.ini
C:\jee8\mysql-8.0.19-winx64\mysql -u root --skip-password
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
```
Zagon:
```
C:\jee8\mysql-8.0.19-winx64\bin\mysqld --defaults-file=C:\jee8\mysql-8.0.19-winx64\my.ini
```

Ustavitev:
```
C:\jee8\mysql-8.0.19-winx64\bin\mysqladmin shutdown --user=root --host=127.0.0.1 --password=root
```

```
C:\jee8\mysql-8.0.19-winx64\mysql -u root -p
p:root
create database testdb
```


WildFly, Eclipse, IntelliJ
==========================

[wildfly-19.0.0.Final.zip](https://wildfly.org/downloads/)

[eclipse-jee-2020-03-R-incubation-win32-x86_64.zip](https://www.eclipse.org/downloads/packages/)

[ideaIU-2019.3.4.win.zip](https://www.jetbrains.com/idea/download/download-thanks.html?platform=windowsZip)

JDBC jar --> standalone/deployments

java:jboss/datasources/mysqlds

java:jboss/datasources/postgresds

porti +20000

```
        <interface name="public">
            <any-address/>
        </interface>
```

```
<extension module="org.wildfly.extension.messaging-activemq"/>
```

```
<subsystem xmlns="urn:jboss:domain:messaging-activemq:9.0">
...
				<jms-queue name="testQueue" entries="jms/queue/test java:jboss/exported/jms/queue/test"/>
				<jms-topic name="testTopic" entries="jms/topic/test java:jboss/exported/jms/topic/test"/>
```

```
	<mdb>
     <resource-adapter-ref resource-adapter-name="${ejb.resource-adapter-name:activemq-ra.rar}"/>
     <bean-instance-pool-ref pool-name="mdb-strict-max-pool"/>
   </mdb>
```

users properties:

```
user=user
guest=guest,guest
```
