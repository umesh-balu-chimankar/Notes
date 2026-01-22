# FROM ubuntu
# RUN apt-get update
# RUN apt-get install apache2 -y
# COPY index.html /var/www/html/index.html
# RUN apt install openjdk-21-jdk -y
# ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.113/bin/apache-tomcat-9.0.113.tar.gz /opt
# WORKDIR /opt
# RUN tar -xzf apache-tomcat-9.0.113.tar.gz -C /opt 
# # hadolint ignore=DL3059
# ENV department=dev
# #ENV key=value
# #ENV department dev
# EXPOSE 8080
# WORKDIR /notes/docker/apache-tomcat-9.0.113/bin
# CMD [ "./catalina.sh", "run" ]
# #ENTRYPOINT ["./catalina.sh", "run" ]

#######################################################

# FROM ubuntu:20.04
# RUN apt-get update
# ENV DEBIAN_FRONTEND=noninteractive
# RUN apt-get install apache2 -y
# COPY index.html /var/www/html/index.html
# EXPOSE 80
# CMD [ "apache2ctl", "-D", "FOREGROUND" ]

########################################################
#multistage docker file

# --- Stage 1: Download and extract Tomcat ---
FROM alpine:3.20 AS downloader

ENV TOMCAT_VERSION=9.0.107
WORKDIR /tmp

RUN apk add --no-cache curl tar ca-certificates && \
    curl -fLO https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    tar -xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz

# --- Stage 2: Final image ---
FROM eclipse-temurin:17-jdk-jammy

ENV CATALINA_HOME=/opt/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH

COPY --from=downloader /tmp/apache-tomcat-* $CATALINA_HOME

EXPOSE 8080

CMD ["catalina.sh", "run"]


