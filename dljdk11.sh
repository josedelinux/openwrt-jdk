#!/bin/sh

set -o errexit
set -o nounset

#set -o pipefail
set -x

REVISION=11.0.11_p9-r0
URL=http://dl-cdn.alpinelinux.org/alpine/v3.14/community
ARCH="aarch64 ppc64le s390x x86_64"
PACKAGES="openjdk11 openjdk11-jdk openjdk11-jre openjdk11-jre-headless"

old_pwd=$(pwd)
tmp_dir=$(mktemp -d -t openjdk11-XXXXXXXXXX)
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
	mkdir "openjdk11-${arch}"
done

#extract apks to corresponding arch dir
for arch in $ARCH;do
	for package in $PACKAGES; do
		tar xzf "${package}-${REVISION}_${arch}.apk" -C "openjdk11-${arch}"
	done
done

for arch in $ARCH;do
	chmod +x "openjdk11-${arch}/usr/lib/jvm/java-11-openjdk/bin/" 
done

#tar them up agains
for arch in $ARCH;do
	tar czf "openjdk-11_${arch}.tar.gz" -C "openjdk11-${arch}/usr/lib/jvm/java-11-openjdk/" .
done



cd "${old_pwd}"

for arch in $ARCH;do
	cp "$tmp_dir/openjdk-11_${arch}.tar.gz" "./"
done

