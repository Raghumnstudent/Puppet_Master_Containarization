sudo docker network create puppet

sudo docker pull puppet/puppetserver:6.0.3
cwd=`pwd`
echo $cwd

sudo docker run --net puppet --name puppet -p8140:8140 -d --hostname puppet-linoxide -v $cwd/puppet.conf:/etc/puppetlabs/puppet/puppet.conf -v $cwd/hiera.yaml:/etc/puppetlabs/puppet/hiera.yaml -v $cwd/fileserver.conf:/etc/puppetlabs/puppet/fileserver.conf -v $cwd/code:/ect/puppetlabs/code/environments/ puppet/puppetserver:6.0.3
