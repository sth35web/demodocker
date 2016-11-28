# 0. Introduction

### Vm vs container
![](https://i0.wp.com/blog.docker.com/wp-content/uploads/2015/08/vm_container.png?w=761&ssl=1)

### Build Ship Run
![](https://www.docker.com/sites/default/files/info-6.png)

### Advantages of running docker
- Rapid application deployment + testing
- Portability across machines
- Version control and component reuse
- Sharing
- Lightweight footprint and minimal overhead
- Simplified maintenance


## Drawbacks


# 1. Installing docker
```
apt-get update
apt-get install -y apt-transport-https ca-certificates linux-image-extra-$(uname -r) linux-image-extra-virtual
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install -y docker-engine
service docker start
usermod -aG docker ubuntu
```
# 2. Introduction to images
```
differences bw images and containers

hub docker +
docker search

official images

tags
```
# 3. Managing containers
```
--help

docker run hello-world
docker --version
pull
run
exec
inspect
rm
ps
stats
logs
```
# 4. Building images

### Images and layers
![](https://docs.docker.com/engine/userguide/storagedriver/images/container-layers.jpg)

### Dockerfile
```
https://github.com/sth35web/demodocker
http://192.168.48.54/
```
# 5. Distributing images
```
docker import /export
public/private registry
docker tag
docker push / pull
docker rmi
```
# 6. Volumes 
```
docker run -d -p 80:80 -v /home/ubuntu/demo/demo:/usr/share/nginx/html/demo  --name nginxsth nginxsth:latest

docker volume create --name nginxhtml

run -d -p 80:80 -v nginxhtml:/usr/share/nginx/html/demo  --name nginxsth nginxsth:latest

echo toto > /var/lib/docker/volumes/nginxhtml/_data/index.html
```
![](https://docs.docker.com/engine/userguide/storagedriver/images/driver-pros-cons.png)

# 7. Networking
```
docker network ls
docker network inspect bridge

docker exec -ti nginxsth bash
  ping 172.17.0.4 => ok
```  
![](https://success.docker.com/@api/deki/files/192/bridge1.png?revision=2)

```
docker network create --driver bridge isolated_nw
docker run -d -P --network=isolated_nw nginxsth:latest
docker network inspect isolated_nw
docker exec -ti fb82aad80f58 bash
  ping 172.18.0.2 => ok
  ping reverent_ramanujan => KO


docker run -d -P --network=isolated_nw --name c1  nginxsth:latest
docker run -d -P --network=isolated_nw --name c2  nginxsth:latest
docker exec -ti c1 bash
  ping c2 => ok
```  
![](https://success.docker.com/@api/deki/files/193/bridge2.png?revision=2)

```
#exemple d'isolation :

docker network create --driver bridge front
docker network create --driver bridge back

docker run -d -P --network=front --network=back --name front1  nginxsth
docker run -d -P --network=front --network=back  --name front2  nginxsth
docker run -d -P --network=front --network=back  --name front3  nginxsth

docker run -d --network=back --name back1  nginxsth
```
# 8. Registry

```
docker run -d -p 5000:5000 \
 --restart=always \
 --name registry  \ 
 -e REGISTRY_STORAGE=swift \ 
 -e REGISTRY_STORAGE_SWIFT_USERNAME=xxxxxxxxxxxx \  
 -e REGISTRY_STORAGE_SWIFT_PASSWORD=xxxxxxxx \  
 -e REGISTRY_STORAGE_SWIFT_AUTHURL=http://xxxxxxxxxxxxxxxxxx \  
 -e REGISTRY_STORAGE_SWIFT_CONTAINER=docker \  
 -v  /home/ubuntu/registry/ca:/etc/ssl/certs/ \ 
 registry:2

docker push 192.168.48.54:5000/google/cadvisor

api
authentification
notifications

portus
```
# 9. Continuous Integration

https://github.com/sth35web/formationdocker/blob/master/Dockerfile
https://hub.docker.com/r/sth35web/formationdocker/builds/
```
gitlabci
```




