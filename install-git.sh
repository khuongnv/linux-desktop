#!/bin/bash
# Cài đặt Git trên Ubuntu/Debian

set -e

if [ "$EUID" -ne 0 ]; then
    echo "Chạy với sudo: sudo bash $0"
    exit 1
fi

apt-get update
apt-get install -y git

echo ""
echo "✅ Đã cài đặt Git."
git --version
echo ""
