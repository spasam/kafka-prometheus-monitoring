#!/bin/bash

if [[ -z "$START_TIMEOUT" ]]; then
    START_TIMEOUT=600
fi

start_timeout_exceeded=false
count=0
step=10
while netstat -lnt | awk '$4 ~ /:'"$KAFKA_PORT"'$/ {exit 1}'; do
    echo "waiting for kafka to be ready"
    sleep $step;
    count=$((count + step))
    if [ $count -gt $START_TIMEOUT ]; then
        start_timeout_exceeded=true
        break
    fi
done

if $start_timeout_exceeded; then
    echo "Not able to auto-create topic (waited for $START_TIMEOUT sec)"
    exit 1
fi

unset JMX_PORT
unset KAFKA_JMX_OPTS

for i in customer audit; do
    ${KAFKA_HOME}/bin/kafka-topics.sh \
      --create \
      --zookeeper ${KAFKA_ZOOKEEPER_CONNECT} \
      --topic ${i} \
      --partitions 1 \
      --replication-factor 1 \
      --if-not-exists &
done

wait

for i in `seq 1 100000`; do echo $i; sleep $(($i % 2)); done | \
  ${KAFKA_HOME}//bin/kafka-console-producer.sh --broker-list localhost:${KAFKA_PORT} --topic customer &

for i in `seq 1 100000`; do echo $i; sleep $(($i % 3)); done | \
  ${KAFKA_HOME}//bin/kafka-console-producer.sh --broker-list localhost:${KAFKA_PORT} --topic audit &

wait
