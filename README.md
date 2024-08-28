# Gradle Dynamic Versions Demo

This project demonstrates an issue with the Spring Dependency Management Gradle plugin where it does not seem to work well with Gradle dynamic versions.

## Issue Description

When using the Spring dependency management plugin in a Spring Boot application, the plugin doesn't seem to respect the dependencies lock file (`gradle.lockfile`) that has been previously generated. Executing any Gradle task, such as a build, will report an error stating that it could not resolve all dependencies.

```
* What went wrong:
Execution failed for task ':compileJava'.
> Could not resolve all files for configuration ':compileClasspath'.
   > Did not resolve 'org.springframework:spring-beans:6.1.11' which has been forced / substituted to a different version: '6.1.12'
   > Did not resolve 'org.springframework:spring-core:6.1.11' which has been forced / substituted to a different version: '6.1.12'
   > Did not resolve 'org.springframework:spring-jcl:6.1.11' which has been forced / substituted to a different version: '6.1.12'
   > Did not resolve 'io.micrometer:micrometer-observation:1.13.2' which has been forced / substituted to a different version: '1.13.3'
   > Did not resolve 'org.apache.tomcat.embed:tomcat-embed-el:10.1.26' which has been forced / substituted to a different version: '10.1.28'
   > Did not resolve 'org.springframework:spring-webmvc:6.1.11' which has been forced / substituted to a different version: '6.1.12'
   > Did not resolve 'org.springframework.boot:spring-boot-starter:3.3.2' which has been forced / substituted to a different version: '3.3.3'
   > Did not resolve 'org.springframework.boot:spring-boot:3.3.2' which has been forced / substituted to a different version: '3.3.3'
   > Did not resolve 'org.springframework:spring-context:6.1.11' which has been forced / substituted to a different version: '6.1.12'
   > Did not resolve 'org.springframework.boot:spring-boot-starter-logging:3.3.2' which has been forced / substituted to a different version: '3.3.3'
   > Did not resolve 'org.springframework:spring-expression:6.1.11' which has been forced / substituted to a different version: '6.1.12'
   > Did not resolve 'org.springframework.boot:spring-boot-autoconfigure:3.3.2' which has been forced / substituted to a different version: '3.3.3'
   > Did not resolve 'org.slf4j:slf4j-api:2.0.13' which has been forced / substituted to a different version: '2.0.16'
   > Did not resolve 'org.springframework:spring-aop:6.1.11' which has been forced / substituted to a different version: '6.1.12'
   > Did not resolve 'io.micrometer:micrometer-commons:1.13.2' which has been forced / substituted to a different version: '1.13.3'
   > Did not resolve 'org.springframework:spring-web:6.1.11' which has been forced / substituted to a different version: '6.1.12'
   > Did not resolve 'ch.qos.logback:logback-classic:1.5.6' which has been forced / substituted to a different version: '1.5.7'
   > Did not resolve 'org.springframework.boot:spring-boot-starter-web:3.3.2' which has been forced / substituted to a different version: '3.3.3'
   > Did not resolve 'org.springframework.boot:spring-boot-starter-tomcat:3.3.2' which has been forced / substituted to a different version: '3.3.3'
   > Did not resolve 'org.slf4j:jul-to-slf4j:2.0.13' which has been forced / substituted to a different version: '2.0.16'
   > Did not resolve 'ch.qos.logback:logback-core:1.5.6' which has been forced / substituted to a different version: '1.5.7'
   > Did not resolve 'org.apache.tomcat.embed:tomcat-embed-websocket:10.1.26' which has been forced / substituted to a different version: '10.1.28'
   > Did not resolve 'org.springframework.boot:spring-boot-starter-json:3.3.2' which has been forced / substituted to a different version: '3.3.3'
   > Did not resolve 'org.apache.tomcat.embed:tomcat-embed-core:10.1.26' which has been forced / substituted to a different version: '10.1.28'
```

This will happen any time a new Spring Boot release occurs which falls under the configured dynamic version. A similar error will occur with any other Maven BOM configured to be managed by the plugin.

On the other hand, using the native Gradle BOM functionality does not cause a similar issue. 

## How to Reproduce

This project contains a script that demonstrates the issue with the plugin:

```
./build-with-plugin.sh
```

To do the same thing but using the Gradle BOM functionality:

```
./build-with-bom.sh
```

Both of these are forced to generate the dependencies lock file using Spring Boot `3.3.2`, even though a more recent version has already been released. After the lock file is generated, the version of Spring Boot used in the build script is changed to `3.3.+` to simulate what would happen when a new version has been released after generating the lock file. Lastly, a clean build is done. 