#sudo docker network create puppet

sudo docker pull puppet/puppetserver:6.0.3

sudo docker run --net puppet --name puppet -p8140:8140 -d --hostname puppet-linoxide -v /home/nraghu/work/puppet_master_container/puppet_container/puppet.conf:/etc/puppetlabs/puppet/puppet.conf -v /home/nraghu/work/puppet_master_container/puppet_container/hiera.yaml:/etc/puppetlabs/puppet/hiera.yaml -v /home/nraghu/work/puppet_master_container/puppet_container/fileserver.conf:/etc/puppetlabs/puppet/fileserver.conf -v /home/nraghu/work/code:/ect/puppetlabs/code/environments/ puppet/puppetserver:6.0.3
