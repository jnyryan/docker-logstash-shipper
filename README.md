# docker-logstash-shipper

a docker container to ship logs to rabbitmq.

## Install from DockerHub

``` bash
sudo docker pull jnyryan/logstash-shipper
sudo docker run -d --name ls1 -v /var/log/:/var/log/ -p 50514:514 -p 59200:9200 -p 59292:9292 -p 59300:9300 jnyryan/logstash-shipper

```

## Build Locally:

```
# sudo docker build -t logstash_image github.com/jnyryan/logstash-shipper.git
sudo docker build -t logstash_image .
sudo docker run -d --name ls1 -v /var/log/:/var/log/ -p 50514:514 -p 59200:9200 -p 59292:9292 -p 59300:9300 logstash_image

```

## Run in Vagrant Virtual Machine

1. Install [VagrantUp](http://www.vagrantup.com/)
2. clone [this repo](github.com/jnyryan/docker-logstash-shipper.git)
3. run ```vagrant up```
4. run ```vagrant ssh```

Once a session to the VM has been established

``` bash

sudo docker build -t logstash_image /vagrant/.
sudo docker run -d --name ls1 -v /var/log/:/var/log/ -p 50514:514 -p 59200:9200 -p 59292:9292 -p 59300:9300 logstash_image

```

## Build the Package and Publish it to Dockerhub

``` bash
sudo docker login
sudo docker pull jnyryan/logstash-shipper
sudo docker build -t jnyryan/logstash-shipper /vagrant/.
sudo docker push jnyryan/logstash-shipper
```


## References


sudo cat /var/lib/docker/containers/9cd394f3e02ef34aa002689687b21580f28c2cd49ff0e4ee63ec2b1bd337b514/root/var/log/rabbitmq/rabbit@rabbithost.log