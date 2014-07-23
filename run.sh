#!/bin/bash

RMQ_HOST=${RMQ_HOST:-127.0.0.1}

if [ "$(ls -A /tmp/etc)" ]; then
	echo "Found config files in /tmp/etc. Using them instead of default"
	cp /tmp/etc/logstash.conf /etc/logstash/conf.d/logstash.conf
else
	sed -i 's/IP_ADDRESS/'"$RMQ_HOST"'/' /etc/logstash/conf.d/logstash.conf
fi

# Dump out configs to test
cat /etc/logstash/conf.d/logstash.conf >> /tmp/etc/test_logstash.log 

/opt/logstash/bin/logstash -f /etc/logstash/conf.d/logstash.conf
