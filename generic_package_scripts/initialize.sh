sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3D1B4472
echo 'deb http://ppa.launchpad.net/openstack-release/2011.3/ubuntu lucid main' | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get -y --allow-unauthenticated --force-yes install git-core bzr debhelper python-m2crypto \
python-all python-sphinx python-distutils-extra python-gflags python-mox python-carrot python-boto python-mock \
python-amqplib python-sqlalchemy python-eventlet python-routes python-webob python-swift \
python-cheetah python-nose python-paste python-pastedeploy python-tempita python-migrate python-netaddr \
python-glance python-paramiko python-novaclient python-lockfile python-simplejson python-lxml pep8 dpkg-dev