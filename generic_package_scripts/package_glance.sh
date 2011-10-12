cd ~
rm -fr glance
mkdir -p glance
cd glance
bzr clone lp:~openstack-ubuntu-packagers/glance/diablo
git clone git://github.com/openstack/glance.git src
cd src
git fetch --tags
git checkout 2011.3
cp -R ../diablo/debian .
DEB_BUILD_OPTIONS=nocheck,nodocs dpkg-buildpackage -rfakeroot -b -uc -us
cd ..
tar czvf glance_debs.tgz glance_* python-glance*
# Now we have our files ~/glance/glance_debs.tgz
cd ~