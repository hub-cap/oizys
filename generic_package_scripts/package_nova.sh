# Assume the first parameter is the REVNO for the package
cd ~
rm -fr nova
mkdir -p nova
cd nova
git clone git://github.com/rackspace/reddwarf.git src
cd src/
git fetch --tags
git checkout stable/diablo

GIT_REVISION=`git --git-dir=.git rev-parse HEAD`
cp -R /vagrant/nova_diablo_scripts/debian .
sed -i.bak "s/Description: \(.*\)/Description: \1 - $GIT_REVISION/g" debian/control
# cp -R packagefiles/debian src/

#Somehow change the revno
sed -i.bak "s/JENKINS_REVNO/$1/g" debian/changelog
sed -i.bak "s/debian\/nova.conf    etc\/nova//g" debian/nova-common.install
DEB_BUILD_OPTIONS=nocheck,nodocs dpkg-buildpackage -rfakeroot -b -uc -us
cd dbaas-mycnf
sed -i.bak "s/\(dbaas-mycnf ([0-9\.-]\+\)/\1-$1/g" debian/changelog
sh builddeb.sh
mv dbaas-mycnf*.deb ../../
cd ../../
tar czvf nova_debs.tgz nova* python-nova* reddwarf-* dbaas-mycnf*.deb
# Now we have our files ~/nova/nova_debs.tgz
cd ~
