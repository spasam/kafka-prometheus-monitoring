FROM wurstmeister/kafka

ADD http://central.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.3.1/jmx_prometheus_javaagent-0.3.1.jar /opt/kafka/libs/jmx_prometheus_javaagent.jar

COPY jmx_prom.yml /opt/kafka/config/

COPY create-topics.sh /usr/bin/

ENV \
  JMX_PORT="1099" \
  KAFKA_JMX_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=127.0.0.1 -Dcom.sun.management.jmxremote.rmi.port=1099 -javaagent:/opt/kafka/libs/jmx_prometheus_javaagent.jar=8080:/opt/kafka/config/jmx_prom.yml"
