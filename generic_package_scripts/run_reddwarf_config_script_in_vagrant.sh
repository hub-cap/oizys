# Get all the information required to ssh into the host vm and run ci
# Assume the first parameter is the REVNO for the package!!!!!
vagrant_ssh() {
    VHOST=`vagrant ssh_config | awk '/HostName/{print $2}'`
    VUSER=`vagrant ssh_config | awk '/User /{print $2}'`
    VPORT=`vagrant ssh_config | awk '/Port/{print $2}'`
    VIDFILE=`vagrant ssh_config | awk '/IdentityFile/{print $2}'`
    ssh ${VUSER}@${VHOST} -p ${VPORT} -i ${VIDFILE} -o NoHostAuthenticationForLocalhost=yes "$@"
}

vagrant_ssh sh /vagrant/initialize.sh

vagrant_ssh sh /vagrant/package_reddwarf_config.sh $1 $2 $3 $4 $5 $6 $7 $8
vagrant_ssh mv /home/vagrant/reddwarf-config/reddwarf-config_debs.tgz /vagrant
