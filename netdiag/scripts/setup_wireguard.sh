#!/bin/bash
set -e

NS1="ns1"
NS2="ns2"
WG1="wg-ns1"
WG2="wg-ns2"
PORT1=51820
PORT2=51821

cleanup() {
    echo "WireGuard setup failed. Rolling back..."
    sudo ip netns exec $NS1 wg-quick down scripts/wg-ns1.conf 2>/dev/null || true
    sudo ip netns exec $NS2 wg-quick down scripts/wg-ns2.conf 2>/dev/null || true
    rm -f ns1.key ns1.pub ns2.key ns2.pub
    exit 1
}
trap cleanup ERR

# Generate keys
wg genkey | tee ns1.key | wg pubkey > ns1.pub
wg genkey | tee ns2.key | wg pubkey > ns2.pub

# Create configs
cat > scripts/wg-ns1.conf <<EOF
[Interface]
PrivateKey = $(cat ns1.key)
Address = 192.168.100.1/24
ListenPort = $PORT1

[Peer]
PublicKey = $(cat ns2.pub)
AllowedIPs = 192.168.100.2/32
Endpoint = 10.0.0.2:$PORT2
EOF

cat > scripts/wg-ns2.conf <<EOF
[Interface]
PrivateKey = $(cat ns2.key)
Address = 192.168.100.2/24
ListenPort = $PORT2

[Peer]
PublicKey = $(cat ns1.pub)
AllowedIPs = 192.168.100.1/32
Endpoint = 10.0.0.1:$PORT1
EOF

#fixing permissions
chmod 600 scripts/wg-ns1.conf scripts/wg-ns2.conf
chmod 600 ns1.key ns2.key

# Bring up WireGuard
sudo ip netns exec $NS1 wg-quick up scripts/wg-ns1.conf
sudo ip netns exec $NS2 wg-quick up scripts/wg-ns2.conf

echo "WireGuard tunnel established between $NS1 and $NS2"

