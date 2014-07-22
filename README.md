# docker-logstash-shipper

a docker container to ship logs to rabbitmq.

## Install from DockerHub

``` bash
sudo docker pull jnyryan/logstash-shipper
sudo docker run -d -h rabbithost -p 5672:5672 -p 15672:15672 jnyryan/logstash-shipper
```

## Build Locally:

```
sudo docker build github.com/jnyryan/logstash-shipper.git
sudo docker run -d -p 5672:5672 -p 15672:15672 jnyryan/logstash-shipper
```

## Run in Vagrant Virtual Machine

1. Install (VagrantUp)[http://www.vagrantup.com/] 
2. clone (this repo)[github.com/jnyryan/docker-logstash-shipper.git]
3. run ```vagrant up```
    

## Build the Package and Publish it to Dockerhub

``` bash
sudo docker login
sudo docker pull jnyryan/logstash-shipper
sudo docker build -t jnyryan/logstash-shipper /vagrant/.
sudo docker push jnyryan/logstash-shipper
```


## References


sudo cat /var/lib/docker/containers/9cd394f3e02ef34aa002689687b21580f28c2cd49ff0e4ee63ec2b1bd337b514/root/var/log/rabbitmq/rabbit@rabbithost.log