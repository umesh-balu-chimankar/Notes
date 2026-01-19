FROM ubuntu
RUN apt-get update
RUN apt-get install apache2 -y
COPY index.html /var/www/html/index.html
RUN apt install openjdk-21-jdk -y
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.113/bin/apache-tomcat-9.0.113.tar.gz /opt
WORKDIR /opt
RUN tar -xzf apache-tomcat-9.0.113.tar.gz -C /opt 
ENV department dev
EXPOSE 8080
WORKDIR /notes/docker/apache-tomcat-9.0.113/bin
CMD [ "./catalina.sh", "run" ]
#ENTRYPOINT ["./catalina.sh", "run" ]