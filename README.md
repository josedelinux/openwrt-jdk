## Get your OpenWrt run OpenJDK(musl-based)

this scripts will automatically download musl-based OpenJDK to current directory 

it works on my raspberry pi 3b+ , my Minecraft server(papermc)  works fine too

Inspired from [Reinhart Previano s' blog](https://dev.to/reinhart1010/apparently-yes-you-can-install-openjdk-java-jre-and-yacy-on-openwrt-1e33) , update packages links

## Get  openjdk(optional)

run `./dljdk8.sh` or `./dljdk11.sh`

## Installation

1. go to  [Release page](https://github.com/josedelinux/openwrt-jdk/releases/) to download OpenJDK according to your architecture
2. Make a directory for the JDK: `mkdir -p /usr/lib/jvm`
3. Extract the archive: `tar zxvf openjdk-version_arch.tar.gz -C /usr/lib/jvm`
4. add `export PATH="/usr/lib/jvm/bin:$PATH"` to `/etc/profile`

