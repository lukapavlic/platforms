# SonarQube 8.5.1

Download: [SonarQubeWin64.zip](https://drive.google.com/file/d/1pRUBrqo68_sJUGnIP0smA2Wl0Bx5Xqly/view?usp=sharing
) ~824MB

### Vsebina paketa:
- OpenJDK 14.0.2
- Apache Maven 3.6.3
- Postgresql 11.2.2 (u:postgres, p:postgres)
- PgAdmin 4
- SonarQube 8.5.1 (port 29000)
- Demo JavaEE projekt

### Navodila:

- Razpakirati v `C:\SonarQubeWin64`
- pg_start
- javacmd
- startsonar --> http://127.0.0.1:29000 (admin, admin)

### Uporaba vgrajene H2 baze namesto Postgresql

C:\SonarQubeWin64\sonarqube-8.5.1.38104\conf\sonar.properties; zakomentirajte vrstice:

- sonar.jdbc.username=postgres
- sonar.jdbc.password=postgres
- sonar.jdbc.url=jdbc:postgresql://localhost/testdb


### Primer skeniranja projekta:
- javacmd
- cd JeeDemoProject\web
- mvn sonar:sonar -Dsonar.projectKey=DemoProject -Dsonar.host.url=http://127.0.0.1:29000 -Dsonar.login=761d41d63e59f7e6612df47ad00453a5f6ec36b9
