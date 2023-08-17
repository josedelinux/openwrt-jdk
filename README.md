# Shell script to get and run musl-based OpenJDK from Alpine package on your OpenWrt router.

This scripts will automatically download musl-based OpenJDK to current directory 

The release page provides compressed tar files for offline installation. These tar file are just untar and tar back gzip tarballs

It works on my raspberry pi 3b+ , my Minecraft server(papermc)  works fine as well.

Inspired from [Reinhart Previano s' blog](https://dev.to/reinhart1010/apparently-yes-you-can-install-openjdk-java-jre-and-yacy-on-openwrt-1e33) , update packages links

## Get openjdk(optional)

run `./dljdk8.sh` or `./dljdk11.sh`

## Installation

1. go to  [Release page](https://github.com/josedelinux/openwrt-jdk/releases/) to download OpenJDK according to your architecture
2. Make a directory for the JDK: `mkdir -p /usr/lib/jvm`
3. Extract the archive: `tar zxvf openjdk-version_arch.tar.gz -C /usr/lib/jvm`
4. add `export PATH="/usr/lib/jvm/bin:$PATH"` to `/etc/profile`
5. reboot and then test java with `java --version`

## Troubleshooting

### Compatibility issue
```stderr
Error relocating /usr/lib/jvm/lib/aarch32/jli/libjli.so: __dlsym_time64: symbol not found
Error relocating /usr/lib/jvm/lib/aarch32/jli/libjli.so: __gettimeofday_time64: symbol not found
Error relocating /usr/lib/jvm/lib/aarch32/jli/libjli.so: __stat_time64: symbol not found
```
As mentioned in [#1](https://github.com/josedelinux/openwrt-jdk/issues/1), this is probably is because your device is using musl version older than v1.2.0.

in that case you will need to use the alpine package before [v3.13](https://wiki.alpinelinux.org/wiki/Release_Notes_for_Alpine_3.13.0), which still uses musl 1.1.

#### Solution
here is a [install script](https://gist.github.com/stokito/7dd425da5a12abce8b39dda1bd1106d7) written by [Sergey Ponomarev](https://github.com/stokito)


## Better solution(todo)

### Packaging it as an OPKG package for easier installation. 

### Building packages from source

---


This repo is **no longer actively maintained** as I stopped tinkering around on my router.
