#!/bin/bash
set -e  # exit on any command failure

NS1="ns1"
NS2="ns2"
VETH1="veth1"
VETH2="veth2"
IP1="10.0.0.1/24"
IP2="10.0.0.2/24"

cleanup() {
    echo "Error occurred. Reverting changes..."
    sudo ip netns del $NS1 2>/dev/null || true
    sudo ip netns del $NS2 2>/dev/null || true
    sudo ip link del $VETH1 2>/dev/null || true
    exit 1
}

trap cleanup ERR

# Cleanup any leftovers first
sudo ip netns del $NS1 2>/dev/null || true
sudo ip netns del $NS2 2>/dev/null || true
sudo ip link del $VETH1 2>/dev/null || true

# Create namespaces
sudo ip netns add $NS1
sudo ip netns add $NS2

# Create veth pair
sudo ip link add $VETH1 type veth peer name $VETH2

# Assign veth ends
sudo ip link set $VETH1 netns $NS1
sudo ip link set $VETH2 netns $NS2

# Bring interfaces up and assign IPs
sudo ip netns exec $NS1 ip link set dev $VETH1 up
sudo ip netns exec $NS2 ip link set dev $VETH2 up
sudo ip netns exec $NS1 ip addr add $IP1 dev $VETH1
sudo ip netns exec $NS2 ip addr add $IP2 dev $VETH2

echo "Namespaces $NS1/$NS2 set up successfully with veth $VETH1/$VETH2 and IPs $IP1/$IP2"
