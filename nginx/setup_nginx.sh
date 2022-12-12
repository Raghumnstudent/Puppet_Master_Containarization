#!/bin/bash

sudo docker network create puppet

sudo docker pull nginx:1.15.5

"echo creating the nginx certificate"

openssl genrsa -out /home/nraghu/work/puppet_master_container/nginx/certs/server.key 2048

openssl req -new -key /home/nraghu/work/puppet_master_container/nginx/certs/server.key -out /home/nraghu/work/puppet_master_container/nginx/certs/server.csr -subj '/CN=www.mydom.com/O=My Company Name LTD./C=US'

openssl x509 -req -in /home/nraghu/work/puppet_master_container/nginx/certs/server.csr -signkey /home/nraghu/work/puppet_master_container/nginx/certs/server.key -out /home/nraghu/work/puppet_master_container/nginx/certs/server.crt

#sudo sh -c "echo -n 'raghu:' >> /home/nraghu/nginx/.htpasswd"
#sudo sh -c "openssl passwd -apr1 >> /home/nraghu/nginx/.htpasswd"

echo "creating the nginx container"

sudo docker run --name test_nginx -d --net puppet -v /home/nraghu/work/puppet_master_container/nginx/default.conf:/etc/nginx/conf.d/default.conf -v /home/nraghu/work/puppet_master_container/nginx/.htpasswd:/etc/nginx/.htpasswd -v /home/nraghu/work/puppet_master_container/nginx/nginx.conf:/etc/nginx/nginx.conf -v /home/nraghu/work/puppet_master_container/nginx/certs/server.csr:/etc/nginx/server.csr -v /home/nraghu/work/puppet_master_container/nginx/certs/server.key:/etc/nginx/server.key -v /home/nraghu/work/puppet_master_container/nginx/certs/server.crt:/etc/nginx/server.crt -v /home/nraghu/packages/:/home/ -p 8141:8141 nginx:1.15.5


