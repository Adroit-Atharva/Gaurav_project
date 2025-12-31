#!/bin/bash
set -e

NS1="ns1"
VPN_TARGET="192.168.100.2"

echo "[test] Pinging WireGuard peer $VPN_TARGET from $NS1 ..."
sudo ip netns exec $NS1 ping -c 3 -W 1 $VPN_TARGET

echo "[test] WireGuard tunnel OK"

echo "----------------------------------------------------------------------------------------------------------"

set -e

NS2="ns2"
VPN_TARGET="192.168.100.1"

echo "[test] Pinging WireGuard peer $VPN_TARGET from $NS2 ..."
sudo ip netns exec $NS2 ping -c 3 -W 1 $VPN_TARGET

echo "[test] WireGuard tunnel OK"
