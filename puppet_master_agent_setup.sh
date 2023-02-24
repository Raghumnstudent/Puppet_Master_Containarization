#! /bin/bash

echo "Creating the docker network for puppet master and agent"
docker network create puppet

echo "Creating the puppet master container 6.0.3"
docker run --net puppet --name puppet -p8140:8140 --hostname puppet-linoxide puppet/puppetserver:6.0.3

echo "Creating puppet agent"
docker run --net puppet --name puppet-client --link puppet --hostname puppet-client-linoxide puppet/puppet-agent-ubuntu:6.0.2 agent --verbose --no-daemonize --summarize

echo "Creating the postgress db for puppet setup"
docker run --net puppet --name puppetdb-postgress -e POSTGRES_PASSWORD=puppetdb -e POSTGRES_USER=puppetdb -d postgres

echo "creating the puppet db by linking the postgress db"
docker run  --net puppet -d -p8082:8081 -p8083:8080 --name puppetdb --link puppetdb-postgress --link puppet puppet/puppetdb:6.0.0
