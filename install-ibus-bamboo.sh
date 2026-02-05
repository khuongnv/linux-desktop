#!/bin/bash
# Cài đặt gõ tiếng Việt với IBus Bamboo (Telex, VNI, VIQR...)
# PPA: https://launchpad.net/~bamboo-engine/+archive/ubuntu/ibus-bamboo

set -e

echo "=========================================="
echo "  CÀI ĐẶT GÕ TIẾNG VIỆT - IBUS BAMBOO"
echo "=========================================="
echo ""

if [ "$EUID" -ne 0 ]; then
    echo "❌ Cần quyền root. Chạy: sudo bash $0"
    exit 1
fi

# 1. Cài đặt phần mềm cần thiết
echo "📦 Đang thêm PPA và cài đặt..."
apt-get install -y software-properties-common
add-apt-repository -y ppa:bamboo-engine/ibus-bamboo
apt-get update
apt-get install -y ibus ibus-bamboo

echo ""
echo "✅ Đã cài đặt ibus và ibus-bamboo"
echo ""

# 2. Khởi động lại IBus (chạy với user thường)
REAL_USER="${SUDO_USER:-$USER}"
if [ -n "$REAL_USER" ] && [ "$REAL_USER" != "root" ]; then
    echo "🔄 Khởi động lại IBus (user: $REAL_USER)..."
    su - "$REAL_USER" -c "ibus-daemon -drx" 2>/dev/null || true
fi
echo ""

echo ""
echo "=========================================="
echo "✅ HOÀN TẤT"
echo "=========================================="
echo ""
echo "📌 Cách dùng:"
echo "   - Chuyển bộ gõ: Super+Space hoặc nhấn biểu tượng bàn phím trên thanh menu"
echo "   - Hoặc: Settings > Keyboard > Input Sources — thêm Vietnamese (Bamboo) nếu chưa thấy"
echo "   - Kiểu gõ: Telex, VNI, VIQR (mặc định Telex)"
echo ""
echo "📌 Nếu chưa thấy Vietnamese (Bamboo):"
echo "   1. Đăng xuất và đăng nhập lại"
echo "   2. Vào Settings > Region & Language > Input Sources > Add (+)"
echo "   3. Chọn Vietnamese > Vietnamese (Bamboo)"
echo ""
