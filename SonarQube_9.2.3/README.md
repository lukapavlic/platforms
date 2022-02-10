# SonarQube 9.2.3

Download: [SonarQube.zip](https://drive.google.com/file/d/13N1ItMJQWSH6w7uS1bXPOFX8fZpbswMz/view?usp=sharing
) ~982MB

### Vsebina paketa:
- OpenJDK 17.0.1
- Postgresql 14.1 (u:postgres, p:postgres)
- PgAdmin 4
- SonarQube 9.2.3 (port 29000)

### Navodila:

- Razpakirati v `C:\_DEV`
- pgsql14_start.bat
- sonarqubeJava17.bat --> http://127.0.0.1:29000 (admin, admin2)

### Uporaba vgrajene H2 baze namesto Postgresql

C:\_DEV\sonarqube9\conf\sonar.properties; zakomentirajte vrstice:

- sonar.jdbc.username=postgres
- sonar.jdbc.password=postgres
- sonar.jdbc.url=jdbc:postgresql://localhost/testdb
