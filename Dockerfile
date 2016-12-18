FROM openjdk:8-jdk
RUN apt-get update && apt-get install -y maven git
RUN git clone https://github.com/apache/knox.git /root/knox.git
# Build an install knox to /
RUN cd /root/knox.git && git checkout v0.10.0-release && mvn -Ppackage,release package -DskipTests && tar xf target/0.10.0/knox-0.10.0.tar.gz -C / && mv /knox-0.10.0 /knox && rm -rf /root/.m2/repository

CMD ["java", "-jar", "/knox/bin/gateway.jar"]
