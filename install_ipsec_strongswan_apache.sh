#!/bin/bash

# 0. หยุดทันทีหากมีคำสั่งใดล้มเหลว
set -e

# สคริปต์สำหรับติดตั้ง IPsec (strongSwan) และ Apache2 บน Ubuntu 22.04
# (สำหรับใช้ใน Docker 'RUN')

# 1. ตั้งค่า environment variables
export DEBIAN_FRONTEND=noninteractive

echo "--- 1. อัปเดตและติดตั้ง Dependencies ---"
# 2. อัปเดตระบบและติดตั้ง strongSwan, Apache2 และเครื่องมือเครือข่ายที่จำเป็น
apt-get update
apt-get install -y \
    tzdata \
    strongswan \
    strongswan-pki \
    libstrongswan-extra-plugins \
    apache2 \
    iptables \
    iproute2 \
    procps \
    vim \
    net-tools \
    iputils-ping \
    iperf3 \
    traceroute \
    curl
rm -rf /var/lib/apt/lists/*

# 3. ตั้งค่า Timezone
echo "--- 2. ตั้งค่า Timezone ---"
ln -fs /usr/share/zoneinfo/Asia/Bangkok /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata

# 4. ตรวจสอบการติดตั้ง
echo "--- 3. ตรวจสอบการติดตั้ง ---"
echo "ตรวจสอบเวอร์ชัน strongSwan ที่ติดตั้ง:"
ipsec --version
echo "ตรวจสอบเวอร์ชัน Apache2 ที่ติดตั้ง:"
apache2 -v


echo "--- การติดตั้ง IPsec (strongSwan) และ Apache2 เสร็จสมบูรณ์! ---"
echo "ไฟล์คอนฟิก IPsec อยู่ที่: /etc/ipsec.conf และ /etc/ipsec.secrets"
echo "ไฟล์คอนฟิก Apache อยู่ที่: /etc/apache2/"