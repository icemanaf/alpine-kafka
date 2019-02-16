# Introduction

This image was created to get Kafka up and running quickly on a Raspberry Pi3 or constrained hardware.
A number of parameters are configurable using enviromental variables.

Please note that Zookeeper is a required dependency.
```


docker run -it -v /<mount>:/kafka/data -p 9092:9092 -e BROKER_ID=<broker_id> -e ZK_CONNECT="<zk_host>:2181" -e ADVERTISED_LISTNERS="PLAINTEXT://<listner_host>:9092" icemanaf/rpi-alpine-kafka


```