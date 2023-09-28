#!/bin/bash

set -exo pipefail

dnf update -y
dnf install -y which git rpm-build rpmdevtools

mkdir -p /src
cd /src
git clone https://src.fedoraproject.org/rpms/swift-lang.git
cd swift-lang
git checkout b1cf890222c620e4be45ae54a48fb6c1ac52465a

rm -rf $HOME/rpmbuild
rpmdev-setuptree

cp * $HOME/rpmbuild/SOURCES/
mv $HOME/rpmbuild/SOURCES/*.spec $HOME/rpmbuild/SPECS/

spectool -g -R  $HOME/rpmbuild/SPECS/swift-lang.spec

dnf builddep -y $HOME/rpmbuild/SPECS/swift-lang.spec

rpmbuild -ba $HOME/rpmbuild/SPECS/swift-lang.spec
