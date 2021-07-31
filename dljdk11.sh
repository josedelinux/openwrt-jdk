#!/bin/sh

set -o errexit
set -o nounset

#try to commentize it when it fails
set -o pipefail
set -x

REVISION=11.0.11_p9-r0
URL=http://dl-cdn.alpinelinux.org/alpine/v3.14/community/aarch64/
PACKAGES="openjdk11 openjdk11-jdk openjdk11-jre openjdk11-jre-headless"

old_pwd=$(pwd)
tmp_dir=$(mktemp -d -t openjdk11-XXXXXXXXXX)
trap "rm -rf $tmp_dir" EXIT

cd "${tmp_dir}"

for package in $PACKAGES; do
    curl -LO "${URL}/${package}-${REVISION}.apk"
done

for package in $PACKAGES; do
    tar -xzf "${package}-${REVISION}.apk"
done


cd "${old_pwd}"
echo $tmp_dir

mv $tmp_dir/usr/lib/jvm/java-11-openjdk ./java-11-openjdk
chmod +x ./java-1.8-openjdk/bin/*
