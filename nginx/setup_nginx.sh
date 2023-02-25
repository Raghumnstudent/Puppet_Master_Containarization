#!/bin/bash

network=`sudo docker network ls | grep -i puppet | awk -F ' ' '{print $2}'`
if [ $network ]; then
   echo "puppet docker network already exits"
else
   sudo docker network create puppet
fi

image=`sudo docker images | grep -i nginx | awk -F ' ' '{print$2}'`
if [ $image ]; then
   echo "The nginx 1.15.5 docker image is already exits"
else
   sudo docker pull nginx:1.15.5
fi

echo "creating the nginx certificate"

cwd=`pwd`

openssl genrsa -out $cwd/certs/server.key 2048

openssl req -new -key $cwd/certs/server.key -out $cwd/certs/server.csr -subj '/CN=www.mydom.com/O=My Company Name LTD./C=US'

openssl x509 -req -in $cwd/certs/server.csr -signkey $cwd/certs/server.key -out $cwd/certs/server.crt

sudo sh -c "echo -n 'raghu:' >> $cwd/.htpasswd"
sudo sh -c "openssl passwd -apr1 >> $cwd/.htpasswd"

echo "creating the nginx container"

sudo docker run --name test_nginx -d --net puppet -v $cwd/default.conf:/etc/nginx/conf.d/default.conf -v $cwd/.htpasswd:/etc/nginx/.htpasswd -v $cwd/nginx.conf:/etc/nginx/nginx.conf -v $cwd/certs/server.csr:/etc/nginx/server.csr -v $cwd/certs/server.key:/etc/nginx/server.key -v $cwd/certs/server.crt:/etc/nginx/server.crt -v $cwd/:/home/ -p 8141:8141 nginx:1.15.5

