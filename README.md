## Get your openwrt run openjdk(musl-based)

this scripts will automatically download musl-based openwrt-jdk to current directory 

it works on my raspberry pi 3b+ , my Minecraft server(papermc)  works fine too

Inspired from [Reinhart Previano s' blog](https://dev.to/reinhart1010/apparently-yes-you-can-install-openjdk-java-jre-and-yacy-on-openwrt-1e33) , update packages links

## Get  openjdk(optional)

run `./dljdk8.sh` or `./dljdk11.sh`

## Installation

1. download [openjdk 8 or 11 on release page](https://github.com/josedelinux/openwrt-jdk/releases/) to your directory where you want to install 
2. run `tar xvzf openjdk*-wrt.tar.gz`
3. run `chmod +x ./java-1.8-openjdk/bin/*` or `chmod +x ./java-11-openjdk/bin/*`
4. add java to path(/etc/profile)
