#!/bin/bash
CFG=${CFG:-}
RM_HOST=${RM_HOST:-127.0.0.1}
EMBEDDED="false"

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
        host => "54.76.2.127"
        exchange_type => direct
        key => "logstash-routing-key"
        durable => "true"
        persistent => "true"
        name => "logstash-exchange"
    }
}
EOF

java -jar /opt/logstash.jar agent -f /opt/logstash.conf
