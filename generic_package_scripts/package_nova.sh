# Assume the first parameter is the REVNO for the package
cd ~
rm -fr nova
mkdir -p nova
cd nova
git clone git://github.com/rackspace/reddwarf.git src
# git clone git://github.com/hub-cap/nova-temp-package-files.git packagefiles
cd src/
cp -R /vagrant/nova_diablo_scripts/debian .
# cp -R packagefiles/debian src/

#Somehow change the revno
sed -i.bak "s/JENKINS_REVNO/$1/g" debian/changelog
DEB_BUILD_OPTIONS=nocheck,nodocs dpkg-buildpackage -rfakeroot -b -uc -us
cd ..
tar czvf nova_debs.tgz nova* python-nova* reddwarf-api*
# Now we have our files ~/nova/nova_debs.tgz
cd ~