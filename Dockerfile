FROM alpine:3.11

#add required packages
RUN  apk add openjdk8  tar  wget bash

#build configurations
ARG KAFKA_VERSION_MJR=2.4.0
ARG KAFKA_VERSION_MIN=2.13

#get kafka
RUN wget -q http://apache.mirror.anlx.net/kafka/2.4.0/kafka_2.13-2.4.0.tgz  && \
tar -xzvf kafka_${KAFKA_VERSION_MIN}-${KAFKA_VERSION_MJR}.tgz && \
rm -rf kafka_${KAFKA_VERSION_MIN}-${KAFKA_VERSION_MJR}.tgz && \
mv kafka_${KAFKA_VERSION_MIN}-${KAFKA_VERSION_MJR} kafka

#runtime configurations
ENV BROKER_ID=0
ENV JMX_PORT=${JMX_PORT:-9910}
ENV ADVERTISED_LISTNERS=localhost
ENV ZK_CONNECT=localhost:2181
ENV KAFKA_PORT=9092
ENV KAFKA_DATA_DIR=/kafka/data
ENV KAFKA_HEAP_OPTS="-Xmx256M -Xms128M"
ENV KAFKA_JVM_PERFORMANCE_OPTS="-client -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:+CMSScavengeBeforeRemark -XX:+DisableExplicitGC -Djava.awt.headless=true"



#copy startup script.
COPY startup.sh /startup.sh 

RUN chmod 777 startup.sh 

CMD ["./startup.sh"]

EXPOSE 9092