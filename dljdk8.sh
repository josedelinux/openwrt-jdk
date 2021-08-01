#!/bin/sh

set -o errexit
set -o nounset

#try to commentize it when it fails
#set -o pipefail
set -x

REVISION="8.282.08-r1"
URL=http://dl-cdn.alpinelinux.org/alpine/v3.14/community
ARCH="aarch64 armhf armv7 ppc64le s390x x86 x86_64"
PACKAGES="openjdk8 openjdk8-jre openjdk8-jre-lib openjdk8-jre-base"

old_pwd=$(pwd)
tmp_dir=$(mktemp -d -t openjdk8-XXXXXXXXXX)
trap "rm -rf $tmp_dir" EXIT

cd "${tmp_dir}"

#download packages
for arch in $ARCH;do
	for package in $PACKAGES; do
		curl -o "${package}-${REVISION}_${arch}.apk" "${URL}/${arch}/${package}-${REVISION}.apk"
	done
done 

#mkdir
for arch in $ARCH;do
	mkdir "openjdk8-${arch}"
done

#extract apks to corresponding arch dir
for arch in $ARCH;do
	for package in $PACKAGES; do
		#tar xzf "${package}-${REVISION}.apk"
		tar xzf "${package}-${REVISION}_${arch}.apk" -C "openjdk8-${arch}"
	done
done

for arch in $ARCH;do
	chmod +x "openjdk8-${arch}/usr/lib/jvm/java-1.8-openjdk/bin/" 
done

#tar them up agains
for arch in $ARCH;do
	tar czf "openjdk-8_${arch}.tar.gz" -C "openjdk8-${arch}/usr/lib/jvm/java-1.8-openjdk/" .
done

cd "${old_pwd}"

for arch in $ARCH;do
	cp "$tmp_dir/openjdk-8_${arch}.tar.gz" "./"
done

