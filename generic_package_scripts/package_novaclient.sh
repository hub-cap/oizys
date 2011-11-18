# Assume the first parameter is the REVNO for the package
cd ~
rm -fr novaclient
mkdir -p novaclient
cd novaclient
git clone git://github.com/rackspace/python-novaclient.git src
cd src
git reset --hard e993af6b50085e3d00af24b0c9a9a006c71f6589
cp -R /vagrant/novaclient_diablo_scripts/debian .
# nuke the tests cuz they require keystone to work... doh
sed -i.bak "s/python setup.py test/#/g" debian/rules
sed -i.bak "s/JENKINS_REVNO/$1/g" debian/changelog
DEB_BUILD_OPTIONS=nocheck,nodocs dpkg-buildpackage -rfakeroot -b -uc -us
cd ..
tar czvf novaclient_debs.tgz python-novaclient*
# Now we have our files ~/novaclient/novaclient_debs.tgz
cd ~