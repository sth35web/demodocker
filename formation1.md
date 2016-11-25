Installing docker
-----------------

```
#en root
apt-get update
apt-get install apt-transport-https ca-certificates install linux-image-extra-$(uname -r) linux-image-extra-virtual
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install docker-engine
service docker start
usermod -aG docker ubuntu
```

introduction to images
----------------------

```
hub docker +
docker search

images officielles

tags
```

managing container
----------------------

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

building images
---------------

```
les layers
dockerfile

https://github.com/sth35web/demodocker
http://192.168.48.54/
```

distributing images
-------------------

```
docker import /export
public/private registry
docker tag
docker push / pull
docker rmi
```

volumes 
-------
```
docker run -d -p 80:80 -v /home/ubuntu/demo/demo:/usr/share/nginx/html/demo  --name nginxsth nginxsth:latest

docker volume create --name nginxhtml

run -d -p 80:80 -v nginxhtml:/usr/share/nginx/html/demo  --name nginxsth nginxsth:latest

echo toto > /var/lib/docker/volumes/nginxhtml/_data/index.html
```

networking
----------
```
docker network ls
docker network inspect bridge

docker exec -ti nginxsth bash
  ping 172.17.0.4 => ok

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


#exemple d'isolation :

docker network create --driver bridge front
docker network create --driver bridge back

docker run -d -P --network=front --network=back --name front1  nginxsth
docker run -d -P --network=front --network=back  --name front2  nginxsth
docker run -d -P --network=front --network=back  --name front3  nginxsth

docker run -d --network=back --name back1  nginxsth
```
