#!/bin/bash
set -e

NS1="ns1"
TARGET="10.0.0.2"

echo "[test] Pinging $TARGET from $NS1 ..."
sudo ip netns exec $NS1 ping -c 3 -W 1 $TARGET

echo "[test] Connectivity OK"

echo "------------------------------------------------------------------------------------------------------"

#!/bin/bash
set -e

NS2="ns2"
TARGET="10.0.0.1"

echo "[test] Pinging $TARGET from $NS2 ..."
sudo ip netns exec $NS2 ping -c 3 -W 1 $TARGET

echo "[test] Connectivity OK"