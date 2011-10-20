# Assume the first parameter is the REVNO for the package
#$1=changelog revno
# Script takes a ton of params and sed's them into the guest.conf
#$2=MYSQL_USER
#$3=MYSQL_PASS
#$4=MYSQL_HOST
#$5=RABBIT_HOST
#$6=RABBIT_PORT
#$7=RABBIT_USER
#$8=RABBIT_PASS

cd ~
rm -fr reddwarf-config
mkdir -p reddwarf-config
cd reddwarf-config
# git clone git://github.com/rackspace/reddwarf.git src
# git clone git://github.com/hub-cap/nova-temp-package-files.git packagefiles
mkdir src/
cd src/
cp -R /vagrant/reddwarf_config_diablo_scripts/debian .
# cp -R packagefiles/debian src/

#Somehow change the revno & all the other values
sed -i.bak "s/JENKINS_REVNO/$1/g" debian/changelog
sed -i.bak "s/MYSQL_USER/$2/g" debian/guest.conf
sed -i.bak "s/MYSQL_PASS/$3/g" debian/guest.conf
sed -i.bak "s/MYSQL_HOST/$4/g" debian/guest.conf
sed -i.bak "s/RABBIT_HOST/$5/g" debian/guest.conf
sed -i.bak "s/RABBIT_PORT/$6/g" debian/guest.conf
sed -i.bak "s/RABBIT_USER/$7/g" debian/guest.conf
sed -i.bak "s/RABBIT_PASS/$8/g" debian/guest.conf

DEB_BUILD_OPTIONS=nocheck,nodocs dpkg-buildpackage -rfakeroot -b -uc -us
cd ..
tar czvf reddwarf-config.tgz reddwarf*deb
# Now we have our files ~/reddwarf-config/reddwarf-config.tgz
cd ~