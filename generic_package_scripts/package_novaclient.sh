cd ~
rm -fr novaclient
mkdir -p novaclient
cd novaclient
bzr clone lp:~openstack-ubuntu-packagers/python-novaclient/diablo
bzr branch lp:python-novaclient -r 113 src
cd src
cp -R ../diablo/debian .
# nuke the tests cuz they require keystone to work... doh
sed -i.bak "s/python setup.py test/#/g" debian/rules
DEB_BUILD_OPTIONS=nocheck,nodocs dpkg-buildpackage -rfakeroot -b -uc -us
cd ..
tar czvf novaclient_debs.tgz python-novaclient*
# Now we have our files ~/novaclient/novaclient_debs.tgz
cd ~