#!/bin/bash

RMQ_HOST=${RM_HOST:-127.0.0.1}

# Create config

cat << EOF > /opt/logstash.conf
input {
 file {
 type => "nginx_access"
 path => ["/var/log/nginx/**"]
 exclude => ["*.gz", "error.*"]
 discover_interval => 10
 }
}
 
filter {
 grok {
 type => nginx_access
 pattern => "%{COMBINEDAPACHELOG}"
 }
}
output {
    amqp {
        host => "IP_ADDRESS"
        exchange_type => direct
        key => "logstash-routing-key"
        durable => "true"
        persistent => "true"
        name => "logstash-exchange"
    }
}
EOF


sed 's/IP_ADDRESS/'"$RMQ_HOST"'/' /etc/logstash/conf.d/logstash.conf

cat /etc/logstash/conf.d/logstash.conf

/opt/logstash/bin/logstash -f /etc/logstash/conf.d/logstash.conf
