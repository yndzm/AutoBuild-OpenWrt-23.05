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
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
# cd /workdir/openwrt
# mosdns
# rm -rf feeds/packages/net/v2ray-geodata
# git clone --depth 1 https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
# git clone --depth 1 https://github.com/sbwml/luci-app-mosdns --single-branch -b v5 package/mosdns
# Add a feed source
# echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
# echo 'src-git passwall_package https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
# echo 'src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2.git' >>feeds.conf.default
# echo 'src-git openclash https://github.com/vernesong/OpenClash.git' >>feeds.conf.default
# echo 'src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main' >>feeds.conf.default
# echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;main' >>feeds.conf.default
# echo 'src-git mosdns https://github.com/sbwml/luci-app-mosdns.git' >>feeds.conf.default
# echo 'src-git redsocks2 https://github.com/semigodking/redsocks.git' >>feeds.conf.default
# Add custom packages
git clone https://github.com/lisaac/luci-app-diskman package/luci-app-diskman
# git clone https://github.com/sirpdboy/luci-app-netdata package/luci-app-netdata
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sirpdboy/luci-app-ddns-go package/ddns-go
git clone https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome
git clone https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
git clone https://github.com/xiaorouji/openwrt-passwall package/luci-app-passwall
# git clone https://github.com/sbwml/luci-app-mosdns package/luci-app-mosdns
# git clone https://github.com/sbwml/luci-app-mosdns package/mosdns
git clone https://github.com/vernesong/OpenClash package/openclash
# git clone https://github.com/linkease/istore-ui package/app-store-ui
# git clone https://github.com/linkease/istore package/luci-app-store
# git clone https://github.com/lionshi/luci-app-poweroff package/luci-app-poweroff
# git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
# git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argo
#eof
./scripts/feeds update -a
./scripts/feeds install -a
