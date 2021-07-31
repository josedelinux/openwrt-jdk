#!/bin/sh

set -o errexit
set -o nounset

#try to commentize it when it fails
#set -o pipefail
set -x

REVISION=8.282.08-r1
URL=http://dl-cdn.alpinelinux.org/alpine/v3.14/community/aarch64/
PACKAGES="openjdk8 openjdk8-jre openjdk8-jre-lib openjdk8-jre-base"

old_pwd=$(pwd)
tmp_dir=$(mktemp -d -t openjdk8-XXXXXXXXXX)
trap "rm -rf $tmp_dir" EXIT

cd "${tmp_dir}"

for package in $PACKAGES; do
    curl -LO "${URL}/${package}-${REVISION}.apk"
done

for package in $PACKAGES; do
    tar xzf "${package}-${REVISION}.apk"
done


cd "${old_pwd}"

mv $tmp_dir/usr/lib/jvm/java-1.8-openjdk ./java-1.8-openjdk
chmod +x ./java-1.8-openjdk/bin/*
