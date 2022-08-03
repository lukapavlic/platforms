# Jakarta EE9, SonarQube, Docker, Demos
Windows Zip

Recomended:
- [jee9_cmu22.zip](https://drive.google.com/file/d/108wF-YFzmvF7pLZYHaGFUlJ6FT4BS1n3/view?usp=sharing) ~2.09GB [Info](#jee9_complete) [Build log](#BuildLog)

# jee9_cmu22 - CMU edition
[download](https://drive.google.com/file/d/108wF-YFzmvF7pLZYHaGFUlJ6FT4BS1n3/view?usp=sharing) ~2.09GB


### Contents:
- OpenJDK 17.0.1
- Eclipse 2022.06
- Wildfly 26.0.1 - Jakarta EE 9
- Postgresql 14.1
- PgAdmin 4
- MySql 8
- SonarQube 9.2.3


### Installation:

- Unzip to `C:\_DEV`
- WildFly port: 8080
- WildFly admin: u:user, p:user
- Postgresql: u:postgres, p:postgres
- Mysql: u:root, p:root
- DS JNDI: java:jboss/datasources/MySqlDS --> mysql (testdb)
- DS JNDI: java:jboss/datasources/PostgresDS --> postgresql (testdb)
- pgsql14_start.bat
- sonarqubeJava17.bat --> http://127.0.0.1:29000 (admin, admin2)

### SQ: using H2 instead of Postgresql

- C:\_DEV\sonarqube9\conf\sonar.properties; comment lines:

- -  sonar.jdbc.username=postgres
- - sonar.jdbc.password=postgres
- - sonar.jdbc.url=jdbc:postgresql://localhost/sonar


# BuildLog

POSTGRESQL
==========
[postgresql-14.1-1-windows-x64-binaries.zip](https://www.enterprisedb.com/download-postgresql-binaries)

[postgresql-42.3.1.jar](https://jdbc.postgresql.org/download.html)

```
C:\_DEV\pgsql14\bin\initdb -D C:\_DEV\pgsql14_data -U postgres -W -E UTF8 -A scram-sha-256
p:postgres
```

run:
```
C:\_DEV\pgsql14\bin\pg_ctl -D C:\_DEV\pgsql14_data -l C:\_DEV\pgsql14_data\log.txt start
```

stop:
```
C:\_DEV\pgsql14\bin\pg_ctl -D C:\_DEV\pgsql14_data stop
```

CLI client:
```
C:\_DEV\pgsql14\bin\psql.exe -U postgres
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

PgAdmin4 run:
```
"C:\_DEV\pgsql14\pgAdmin 4\bin\pgAdmin4.exe"
```

MYSQL
=====
[VC_redist.x64.exe](https://support.microsoft.com/en-us/help/2977003/the-latest-supported-visual-c-downloads)

[mysql-8.0.27-winx64.zip](https://dev.mysql.com/downloads/mysql/)

[mysql-connector-java-8.0.27.zip](https://dev.mysql.com/downloads/connector/j/)

my.ini:
```
[mysqld]
basedir=C:/_DEV/mysql-8.0.19-winx64
datadir=C:/_DEV/mysql-8.0.19-winx64/data
default-time-zone='+01:00'
```

```
C:\_DEV\mysql-8.0.19-winx64\bin\mysqld --defaults-file=C:\_DEV\mysql-8.0.19-winx64\my.ini --initialize-insecure
C:\_DEV\mysql-8.0.19-winx64\bin\mysqld --defaults-file=C:\_DEV\mysql-8.0.19-winx64\my.ini
C:\_DEV\mysql-8.0.19-winx64\mysql -u root --skip-password
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
```
Run:
```
C:\_DEV\mysql-8.0.19-winx64\bin\mysqld --defaults-file=C:\_DEV\mysql-8.0.19-winx64\my.ini
```

Stop:
```
C:\_DEV\mysql-8.0.19-winx64\bin\mysqladmin shutdown --user=root --host=127.0.0.1 --password=root
```

```
C:\_DEV\mysql-8.0.19-winx64\mysql -u root -p
p:root
create database testdb
```


WildFly, Eclipse, IntelliJ
==========================

[wildfly-preview-26.0.1.Final.zip](https://wildfly.org/downloads/)

[eclipse-jee-2022-06-R-win32-x86_64.zip](https://www.eclipse.org/downloads/packages/)

JDBC jar --> standalone/deployments

java:jboss/datasources/mysqlds

java:jboss/datasources/postgresds

---

TBD:

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
