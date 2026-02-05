#!/bin/bash
# Script kiểm tra driver và phần cứng

echo "=========================================="
echo "  BÁO CÁO KIỂM TRA DRIVER VÀ PHẦN CỨNG"
echo "=========================================="
echo ""

# Màu sắc cho output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "📋 THÔNG TIN HỆ THỐNG:"
echo "----------------------"
uname -r
echo ""

echo "🎮 CARD ĐỒ HỌA (VGA/GPU):"
echo "----------------------"
VGA_INFO=$(lspci | grep -i "vga\|3d\|display")
if [ ! -z "$VGA_INFO" ]; then
    echo "$VGA_INFO"
    DRIVER=$(lspci -k | grep -A 2 "VGA" | grep "Kernel driver in use" | awk '{print $NF}')
    if [ ! -z "$DRIVER" ]; then
        echo -e "${GREEN}✓ Driver: $DRIVER${NC}"
    else
        echo -e "${RED}✗ Chưa có driver${NC}"
    fi
else
    echo -e "${YELLOW}⚠ Không tìm thấy card đồ họa${NC}"
fi
echo ""

echo "📡 WIRELESS/WIFI:"
echo "----------------------"
WIFI_INFO=$(lspci | grep -i "network\|wireless\|wifi")
if [ ! -z "$WIFI_INFO" ]; then
    echo "$WIFI_INFO"
    DRIVER=$(lspci -k | grep -A 2 "Network controller" | grep "Kernel driver in use" | awk '{print $NF}')
    if [ ! -z "$DRIVER" ]; then
        echo -e "${GREEN}✓ Driver: $DRIVER${NC}"
        WIFI_IFACE=$(ip link show | grep -i "wlan\|wifi" | awk -F: '{print $2}' | tr -d ' ')
        if [ ! -z "$WIFI_IFACE" ]; then
            echo -e "${GREEN}✓ Interface: $WIFI_IFACE${NC}"
        fi
    else
        echo -e "${RED}✗ Chưa có driver${NC}"
    fi
else
    echo -e "${YELLOW}⚠ Không tìm thấy adapter WiFi${NC}"
fi
echo ""

echo "🔌 ETHERNET:"
echo "----------------------"
ETH_INFO=$(lspci | grep -i "ethernet")
if [ ! -z "$ETH_INFO" ]; then
    echo "$ETH_INFO"
    DRIVER=$(lspci -k | grep -A 2 "Ethernet" | grep "Kernel driver in use" | awk '{print $NF}')
    if [ ! -z "$DRIVER" ]; then
        echo -e "${GREEN}✓ Driver: $DRIVER${NC}"
    else
        echo -e "${RED}✗ Chưa có driver${NC}"
    fi
else
    echo -e "${YELLOW}⚠ Không tìm thấy adapter Ethernet (có thể laptop không có)${NC}"
fi
echo ""

echo "🔊 AUDIO:"
echo "----------------------"
AUDIO_INFO=$(lspci | grep -i "audio")
if [ ! -z "$AUDIO_INFO" ]; then
    echo "$AUDIO_INFO"
    AUDIO_COUNT=$(aplay -l 2>/dev/null | grep -c "^card")
    if [ "$AUDIO_COUNT" -gt 0 ]; then
        echo -e "${GREEN}✓ Tìm thấy $AUDIO_COUNT audio device(s)${NC}"
        aplay -l 2>/dev/null | head -5
    else
        echo -e "${YELLOW}⚠ Không tìm thấy audio device${NC}"
    fi
else
    echo -e "${YELLOW}⚠ Không tìm thấy audio controller${NC}"
fi
echo ""

echo "📶 BLUETOOTH:"
echo "----------------------"
BT_INFO=$(lsusb | grep -i "bluetooth")
if [ ! -z "$BT_INFO" ]; then
    echo "$BT_INFO"
    BT_STATUS=$(rfkill list | grep -A 1 "hci0" | grep "Soft blocked" | awk '{print $4}')
    if [ "$BT_STATUS" = "no" ]; then
        echo -e "${GREEN}✓ Bluetooth không bị block${NC}"
    else
        echo -e "${YELLOW}⚠ Bluetooth bị soft block${NC}"
    fi
else
    echo -e "${YELLOW}⚠ Không tìm thấy Bluetooth adapter${NC}"
fi
echo ""

echo "🔍 KIỂM TRA THIẾT BỊ THIẾU DRIVER:"
echo "----------------------"
if [ "$EUID" -eq 0 ]; then
    UNCLAIMED=$(lspci -k | grep -i "unclaimed\|no driver" || echo "")
    if [ -z "$UNCLAIMED" ]; then
        echo -e "${GREEN}✓ Không có thiết bị nào thiếu driver${NC}"
    else
        echo -e "${RED}✗ Có thiết bị thiếu driver:${NC}"
        echo "$UNCLAIMED"
    fi
else
    echo -e "${YELLOW}⚠ Cần quyền sudo để kiểm tra chi tiết${NC}"
fi
echo ""

echo "📦 DRIVER ĐƯỢC QUẢN LÝ BỞI DKMS:"
echo "----------------------"
DKMS_STATUS=$(dkms status 2>/dev/null)
if [ ! -z "$DKMS_STATUS" ]; then
    echo "$DKMS_STATUS"
else
    echo -e "${YELLOW}⚠ Không có driver nào được quản lý bởi DKMS (bình thường nếu dùng driver kernel)${NC}"
fi
echo ""

echo "=========================================="
echo "  KẾT LUẬN"
echo "=========================================="
echo ""
echo "Để kiểm tra driver đồ họa chi tiết, chạy:"
echo "  sudo apt install mesa-utils"
echo "  glxinfo | grep -i 'opengl\|renderer'"
echo ""
echo "Để xem tất cả module đã load:"
echo "  lsmod"
echo ""
