#!/bin/sh
sed -i "s!broker.id=0!broker.id=${BROKER_ID}!g" /kafka/config/server.properties
sed -i "s!log.dirs=/tmp/kafka-logs!log.dirs=${KAFKA_DATA_DIR}!g" /kafka/config/server.properties 
sed -i "s!zookeeper.connect=localhost:2181!zookeeper.connect=${ZK_CONNECT}!g" /kafka/config/server.properties
sed -i "\$aPORT=${KAFKA_PORT}" /kafka/config/server.properties
sed -i "\$aadvertised.listeners=${ADVERTISED_LISTNERS}" /kafka/config/server.properties 
./kafka/bin/kafka-server-start.sh /kafka/config/server.properties
