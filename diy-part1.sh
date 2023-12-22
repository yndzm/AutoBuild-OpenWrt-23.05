#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/adguardhome
# Add a feed source
# echo 'src-git passwall_package https://github.com/xiaorouji/openwrt-passwall.git;main' >>feeds.conf.default
# echo 'src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main' >>feeds.conf.default
# echo 'src-git openclash https://github.com/vernesong/OpenClash.git' >>feeds.conf.default
# echo 'src-git mosdns https://github.com/sbwml/luci-app-mosdns.git' >>feeds.conf.default
# echo 'src-git redsocks2 https://github.com/semigodking/redsocks.git' >>feeds.conf.default
# Add custom packages
# git clone https://github.com/lisaac/luci-app-diskman.git package/luci-app-diskman
# git clone -b js https://github.com/sirpdboy/luci-theme-kucat.git package/luci-theme-kucat
# git clone https://github.com/chenmozhijin/luci-app-adguardhome.git package/luci-app-adguardhome
# git clone https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
# svn export https://github.com/xiaorouji/openwrt-passwall/trunk/luci-app-passwall package/luci-app-passwall
# svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
# svn export https://github.com/sbwml/luci-app-mosdns/trunk/mosdns package/mosdns
# svn export https://github.com/sbwml/luci-app-mosdns/trunk/v2dat package/v2dat
# svn export https://github.com/sbwml/luci-app-mosdns/trunk/luci-app-mosdns package/luci-app-mosdns
# git clone https://github.com/sirpdboy/luci-app-netdata package/luci-app-netdata
# git clone https://github.com/lionshi/luci-app-poweroff package/luci-app-poweroff
# git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
# git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
#eof
# luci-theme-kucat
# git clone -b js https://github.com/sirpdboy/luci-theme-kucat.git package/luci-theme-kucat

#克隆passwall环境插件
#git clone https://github.com/xiaorouji/openwrt-passwall-packages.git package/passwall

# openclash
cd /workdir
#预置OpenClash内核和GEO数据
export CORE_VER=https://raw.githubusercontent.com/vernesong/OpenClash/core/dev/core_version
export CORE_TUN=https://github.com/vernesong/OpenClash/raw/core/dev/premium/clash-linux
export CORE_DEV=https://github.com/vernesong/OpenClash/raw/core/dev/dev/clash-linux
export CORE_MATE=https://github.com/vernesong/OpenClash/raw/core/dev/meta/clash-linux

export CORE_TYPE=$(echo x86_64 | grep -Eiq "64|86" && echo "amd64" || echo "arm64")
export TUN_VER=$(curl -sfL $CORE_VER | sed -n "2{s/\r$//;p;q}")

export GEO_MMDB=https://github.com/alecthw/mmdb_china_ip_list/raw/release/lite/Country.mmdb
export GEO_SITE=https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geosite.dat
export GEO_IP=https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geoip.dat

git clone --depth=1 --single-branch --branch "dev" https://github.com/vernesong/OpenClash.git

cd OpenClash/luci-app-openclash/root/etc/openclash
curl -sfL -o ./Country.mmdb $GEO_MMDB
curl -sfL -o ./GeoSite.dat $GEO_SITE
curl -sfL -o ./GeoIP.dat $GEO_IP

mkdir ./core && cd ./core

curl -sfL -o ./tun.gz "$CORE_TUN"-"$CORE_TYPE"-"$TUN_VER".gz
gzip -d ./tun.gz && mv ./tun ./clash_tun

curl -sfL -o ./meta.tar.gz "$CORE_MATE"-"$CORE_TYPE".tar.gz
tar -zxf ./meta.tar.gz && mv ./clash ./clash_meta

curl -sfL -o ./dev.tar.gz "$CORE_DEV"-"$CORE_TYPE".tar.gz
tar -zxf ./dev.tar.gz

chmod +x ./clash* ; rm -rf ./*.gz

cd /workdir/OpenClash
cp -r luci-app-openclash /workdir/openwrt/package/

#克隆的源码放在small文件夹
mkdir package/small
pushd package/small

#克隆源码
#passwall
#git clone -b main --depth 1 https://github.com/xiaorouji/openwrt-passwall.git
#mosdns
git clone -b v5 --depth 1 https://github.com/sbwml/luci-app-mosdns.git
#v2ray-geodata
#git clone https://github.com/sbwml/v2ray-geodata
#smartdns
#git clone --depth=1 https://github.com/pymumu/luci-app-smartdns.git
#git clone --depth=1 https://github.com/pymumu/openwrt-smartdns.git
#adguardhome
git clone --depth 1 https://github.com/chenmozhijin/luci-app-adguardhome.git
#OpenClash
#git clone --depth 1 https://github.com/vernesong/OpenClash.git
#diskman
#git clone --depth 1 https://github.com/lisaac/luci-app-diskman.git
