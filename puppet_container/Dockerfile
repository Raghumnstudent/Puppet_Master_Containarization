FROM puppet/puppetserver:6.0.3
MAINTAINER nraghu nraghu@zeomega.com

# Copy Puppet configuration files
COPY puppet.conf /etc/puppetlabs/puppet/puppet.conf
COPY hiera.yaml  /etc/puppetlabs/puppet/hiera.yaml
COPY fileserver.conf /etc/puppetlabs/puppet/fileserver.conf

# Expose Puppet server ports
EXPOSE 8140

# Start the Puppet server
CMD ["puppetserver", "foreground"]
