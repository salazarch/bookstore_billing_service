FROM openjdk:8-jdk-alpine

VOLUME /tmp

COPY target/bookstore-*.jar billing-service.jar
COPY dockerize dockerize
COPY ./Appdynamics /opt/appdynamics/

ENV APPDYNAMICS_AGENT_APPLICATION_NAME=Bookstore-Harness-Demo
ENV APPDYNAMICS_AGENT_ACCOUNT_NAME=advancedtechnologiesdacsadecv
ENV APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY=c9c1b555-efa1-4702-8401-a1b427efe061
ENV APPDYNAMICS_CONTROLLER_HOST_NAME=advancedtechnologiesdacsadecv.saas.appdynamics.com
ENV APPDYNAMICS_CONTROLLER_PORT=443
ENV APPDYNAMICS_CONTROLLER_SSL_ENABLED=true

CMD ./dockerize -wait tcp://bookstore-mysql-db:3306 -timeout 15m java -javaagent:/opt/appdynamics/javaagent.jar -Dappdynamics.agent.nodeName=$HOSTNAME$DEPLOYMENT -Djava.security.egd=file:/dev/./urandom -jar /billing-service.jar