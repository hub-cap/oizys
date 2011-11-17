# Assume the first parameter is the REVNO for the package
cd ~
rm -fr swift
mkdir -p swift
cd swift
git clone git://github.com/openstack/swift.git src
cd src
git fetch --tags
git checkout stable/diablo

cp -R /vagrant/swift_diablo_scripts/debian .
sed -i.bak "s/JENKINS_REVNO/$1/g" debian/changelog
DEB_BUILD_OPTIONS=nocheck,nodocs dpkg-buildpackage -rfakeroot -b -uc -us
cd ..
tar czvf swift_debs.tgz *swift*deb
# Now we have our files ~/swift/swift_debs.tgz
cd ~