FROM openjdk:8-jdk
RUN apt-get update && apt-get install -y maven git
RUN git clone https://github.com/apache/knox.git /root/knox.git
# Build an install knox to /
RUN cd /root/knox.git && git checkout v0.10.0-release && mvn -Ppackage,release package -DskipTests && tar xf target/0.10.0/knox-0.10.0.tar.gz -C /
#RUN echo -e "master-secret\nmaster-secret\n" | /knox/bin/knoxcli.sh create-master --force
#RUN /knox/bin/knoxcli.sh create-cert --hostname hw10447.local

COPY keystores/* /knox-0.10.0/data/security/keystores/
COPY master /knox-0.10.0/data/security/

CMD ["java", "-jar", "/knox-0.10.0/bin/gateway.jar"]
