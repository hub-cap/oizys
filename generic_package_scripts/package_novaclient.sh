cd ~
rm -fr novaclient
mkdir -p novaclient
cd novaclient
bzr branch lp:python-novaclient -r 113 src
cd src
cp -R /vagrant/novaclient_diablo_scripts/debian .
# nuke the tests cuz they require keystone to work... doh
sed -i.bak "s/python setup.py test/#/g" debian/rules
DEB_BUILD_OPTIONS=nocheck,nodocs dpkg-buildpackage -rfakeroot -b -uc -us
cd ..
tar czvf novaclient_debs.tgz python-novaclient*
# Now we have our files ~/novaclient/novaclient_debs.tgz
cd ~