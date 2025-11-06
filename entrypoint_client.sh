#!/bin/bash
set -e

echo "--- IPsec Server & Apache Entrypoint Script Started ---"

# --- IPsec Subnet (ต้องตรงกับ ipsec.conf) ---
VPN_SUBNET="10.10.10.0/24" # <-- ⚠️ ตรวจสอบให้ตรงกับ rightsourceip

# --- Apply Kernel Parameters ---
echo "Applying Kernel Parameters (sysctl)..."
sysctl -w net.ipv4.ip_forward=1 || echo "Warning: Failed to set ip_forward"
sysctl -w net.ipv4.conf.all.accept_redirects=0 || true
sysctl -w net.ipv4.conf.all.send_redirects=0 || true
sysctl -w net.ipv4.conf.all.rp_filter=0 || true
sysctl -w net.ipv4.conf.default.rp_filter=0 || true

# --- Apply iptables rules ---
echo "Applying iptables NAT & Forwarding rules for $VPN_SUBNET..."
iptables -t nat -A POSTROUTING -s $VPN_SUBNET -o eth0 -j MASQUERADE
iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -s $VPN_SUBNET -j ACCEPT

echo "iptables rules applied."





# --- Check config files ---
echo "Checking IPsec configuration files..."
echo "--- /etc/ipsec.conf ---"; cat /etc/ipsec.conf
echo "--- /etc/ipsec.secrets ---"; ls -l /etc/ipsec.secrets || echo "Not found."

# --- Start strongSwan in foreground ---
echo "Starting strongSwan (ipsec start --nofork)..."
# exec ipsec start --nofork


# 2. รัน tail -f /dev/null ในเบื้องหน้า (Foreground)
# นี่คือคำสั่งหลักที่จะยึดให้ container ทำงานต่อไป
echo "Container is running... (tail -f /dev/null)"
tail -f /dev/null