#!/bin/bash

####################
# Prerequisites

apt-get update
apt-get install -y make curl git 

#####################
# Install docker
sudo apt-get install -y docker.io
sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker
sudo sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io

#####################
# Build Container
#docker build -t shipper_img /vagrant/.
#docker run --name shipper -d -v /var/log:/var/log -e RABBITMQ_SERVER="127.0.0.1" -t shipper_img

mkdir -p /tmp/etc && cp /vagrant/etc/logstash2.conf /tmp/etc/logstash.conf

####################
# Test by Installing logstash locally

wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
# Create the Elasticsearch source list
echo 'deb http://packages.elasticsearch.org/elasticsearch/1.1/debian stable main' | sudo tee /etc/apt/sources.list.d/elasticsearch.list
# Create the LogStash source list
echo 'deb http://packages.elasticsearch.org/logstash/1.4/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash.list
apt-get update

apt-get install -y nginx
apt-get install -y logstash=1.4.1-1-bd507eb
cp /vagrant/etc/logstash.conf /etc/logstash/conf.d/logstash.conf
#/opt/logstash/bin/logstash -f /etc/logstash/conf.d/logstash.conf
#service logstash start

echo 192.81.131.15 - - [23/Jul/2014:14:56:48 +0000] "GET / HTTP/1.0" 200 2089 "-" "research-scanner/1.0 (www.internetscanningproject.org)" >> /tmp/test.log 
