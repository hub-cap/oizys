# This file will mod a package so that it uses a different version string than the one it was originally built with.
# This is useful if you need the _same_ code packaged into mulitple debs w/ different names, such as names that
# are environment based, dev, qa, etc.....

deb_full_path=$1
old_version_string=$2
new_version_string=$3

rm -fr tmpdir/
mkdir tmpdir/
cd tmpdir/

# unpackage the deb
dpkg-deb -x $deb_full_path .
dpkg-deb -e $deb_full_path

# Change the version string
sed -i.bak "s/$old_version_string/$new_version_string/g" DEBIAN/control

# repackage the deb
dpkg-deb -b . $deb_full_path

# rename the file based on the new versionstring
deb_full_path_new_file=`echo $deb_full_path|sed "s/$old_version_string/$new_version_string/g"`
mv $deb_full_path $deb_full_path_new_file

