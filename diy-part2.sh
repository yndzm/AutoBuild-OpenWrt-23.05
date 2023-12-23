#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
#修改版本为编译日期
#cp -f feeds/smpackage/.github/diy/banner package/base-files/files/etc/banner
#sed -i "s/%D %V, %C/openwrt $(date +'%m.%d') by Masaaki/g" package/base-files/files/etc/banner
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='OpenWrt by Masaaki'/g"  package/base-files/files/etc/openwrt_release
echo "uci -q batch << EOI
set network.lan.ipaddr='192.168.1.11'
commit network
set wireless.radio0.htmode='HT20'
set wireless.radio0.band='2g'
set wireless.radio0.channel='auto'
set wireless.@wifi-iface[0].ssid='OpenWrt2023'
set wireless.@wifi-device[0].disabled='0'
set wireless.radio1.htmode='VHT40'
set wireless.radio1.band='5g'
set wireless.radio1.channel='auto'
set wireless.@wifi-iface[1].ssid='OpenWrt2023-5G'
set wireless.@wifi-device[1].disabled='0'
commit wireless
set system.@system[-1].timezone='CST-8'
set system.@system[-1].zonename='Asia/Shanghai'
commit system
del dhcp.lan.ra
del dhcp.lan.ra_slaac
del dhcp.lan.ra_flags
del dhcp.lan.dhcpv6
commit dhcp
EOI" > package/base-files/files/etc/uci-defaults/99-custom
#eof
