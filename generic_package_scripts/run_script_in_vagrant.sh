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

vagrant_ssh sh /vagrant/package_nova.sh $1
vagrant_ssh mv /home/vagrant/nova/nova_debs.tgz /vagrant

vagrant_ssh sh /vagrant/package_glance.sh $1
vagrant_ssh mv /home/vagrant/glance/glance_debs.tgz /vagrant

vagrant_ssh sh /vagrant/package_novaclient.sh $1
vagrant_ssh mv /home/vagrant/novaclient/novaclient_debs.tgz /vagrant

vagrant_ssh sh /vagrant/package_nova_guest.sh $1
vagrant_ssh mv /home/vagrant/guest/guest_debs.tgz /vagrant