FROM alpine:latest

#add required packages
RUN  apk add openjdk8  tar  wget bash

#get kafka
RUN wget -q http://apache.mirror.anlx.net/kafka/2.0.0/kafka_2.11-2.0.0.tgz && \
tar -xzvf kafka_2.11-2.0.0.tgz && \
mv kafka_2.11-2.0.0 kafka && \
rm -rf kafka_2.11-2.0.0.tgz

#configurations
ENV BROKER_ID=0
ENV JMX_PORT=${JMX_PORT:-9999}
ENV ADVERTISED_LISTNERS=localhost
ENV ZK_CONNECT=localhost:2181
ENV KAFKA_PORT=9092
ENV KAFKA_DATA_DIR=/kafka/data
ENV KAFKA_HEAP_OPTS="-Xmx256M -Xms128M"
ENV KAFKA_JVM_PERFORMANCE_OPTS="-client -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:+CMSScavengeBeforeRemark -XX:+DisableExplicitGC -Djava.awt.headless=true"

#copy startup script.
COPY startup.sh /startup.sh
RUN mkdir $KAFKA_DATA_DIR && \  
chmod 777 startup.sh

CMD ["./startup.sh"]

EXPOSE 9092