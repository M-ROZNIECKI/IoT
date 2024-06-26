#!/bin/sh
IP="$(ip -o -4 addr list eth1 | awk '{print $4}' | cut -d/ -f1)"

apk add --no-cache curl
curl -sfL https://get.k3s.io -o /tmp/k3s_install.sh
chmod +x /tmp/k3s_install.sh
K3S_URL=https://192.168.56.110:6443 K3S_TOKEN_FILE=/mnt/shared/node-token /tmp/k3s_install.sh --node-ip "$IP"
