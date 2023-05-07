#!/bin/bash

network=`sudo docker network ls | grep -i puppet | awk -F ' ' '{print$2}'`

if [ $network ];then
   echo "Puppet docker network already exit"
else
   sudo docker network create puppet
fi

image=`sudo docker images | grep -i puppet/puppetserver | awk -F ' ' '{print$2}'`
if [ $image ];then
   echo "The puppet server 6.0.3 already exits"
else
   sudo docker pull puppet/puppetserver:6.0.3
fi

cwd=`pwd`
echo $cwd

sudo docker run --net puppet --name puppet -p8140:8140 -d --hostname puppet-linoxide -v $cwd/puppet.conf:/etc/puppetlabs/puppet/puppet.conf -v $cwd/hiera.yaml:/etc/puppetlabs/puppet/hiera.yaml -v $cwd/fileserver.conf:/etc/puppetlabs/puppet/fileserver.conf -v $cwd/code:/ect/puppetlabs/code/environments/ puppet/puppetserver:6.0.3
