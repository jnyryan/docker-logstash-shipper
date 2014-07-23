FROM ubuntu
MAINTAINER jnyryan "http://jnyryan.github.io"

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get update && apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository ppa:webupd8team/java -y

RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y wget oracle-java7-installer

RUN wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
RUN echo 'deb http://packages.elasticsearch.org/elasticsearch/1.1/debian stable main' | sudo tee /etc/apt/sources.list.d/elasticsearch.list
RUN echo 'deb http://packages.elasticsearch.org/logstash/1.4/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash.list
RUN apt-get update

RUN apt-get install -y logstash=1.4.1-1-bd507eb
ADD ./etc/logstash.conf /etc/logstash/conf.d/logstash.conf

ADD run.sh /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
RUN rm -rf /tmp/*
RUN mkdir -p /tmp/etc

CMD ["/usr/local/bin/run"]
