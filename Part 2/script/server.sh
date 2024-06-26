#!/bin/sh
IP="$(ip -o -4 addr list eth1 | awk '{print $4}' | cut -d/ -f1)"

apk add --no-cache curl
curl -sfL https://get.k3s.io -o /tmp/k3s_install.sh
chmod +x /tmp/k3s_install.sh
/tmp/k3s_install.sh --node-ip "$IP" --write-kubeconfig-mode 644
echo "Wait for k3s..."
until [ -f /var/lib/rancher/k3s/server/node-token ]; do
	sleep 1
done
echo "Wait for k3s done"
kubectl apply -f "/var/IoTconfs/configmap.yaml"
kubectl apply -f "/var/IoTconfs/deployments.yaml"
kubectl apply -f "/var/IoTconfs/services.yaml"
kubectl apply -f "/var/IoTconfs/ingress.yaml"
