#!/bin/bash
set -o errexit
set -o nounset
#set -o pipefail
set -x

REVISION="8.275.01-r0"
URL="https://dl-cdn.alpinelinux.org/alpine/v3.12/community"
ARCH="aarch64 armhf armv7 ppc64le s390x x86 x86_64"
PACKAGES="openjdk8 openjdk8-jre openjdk8-jre-lib openjdk8-jre-base"

old_pwd=$(pwd)
tmp_dir=$(mktemp -d -t openjdk8-XXXXXXXXXX)
trap "rm -rf $tmp_dir" EXIT

cd "${tmp_dir}"

for arch in $ARCH; do
	mkdir -p "openjdk8-${arch}/data/"
	cp -r "$old_pwd/build/control/" "$old_pwd/build/debian-binary" "openjdk8-${arch}/"
	for package in $PACKAGES; do
		# download packages
		wget -O "${package}-${REVISION}_${arch}.apk" "${URL}/${arch}/${package}-${REVISION}.apk"
		# extract apks to corresponding arch dir
		tar xzf "${package}-${REVISION}_${arch}.apk" -C "openjdk8-${arch}/data/" --exclude=.PKGINFO --exclude=.SIGN*
	done
	chmod +x "openjdk8-${arch}/data/usr/lib/jvm/java-1.8-openjdk/bin/"
	# tar them into opkg package
	pushd "./openjdk8-${arch}/control/"
	tar --numeric-owner --group=0 --owner=0 -czf ../control.tar.gz ./*
	popd
	pushd "./openjdk8-${arch}/data/"
	tar --numeric-owner --group=0 --owner=0 -czf ../data.tar.gz ./*
	popd
	pushd "./openjdk8-${arch}/"
	tar --numeric-owner --group=0 --owner=0 -czf "./openjdk8_$REVISION.$arch.ipk" ./debian-binary ./data.tar.gz ./control.tar.gz
	popd
done

cd "${old_pwd}"

for arch in $ARCH;do
	cp "$tmp_dir/openjdk8-${arch}/openjdk8_$REVISION.$arch.ipk" ./
done
