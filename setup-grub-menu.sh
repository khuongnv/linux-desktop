#!/bin/bash
# Cấu hình GRUB: hiện menu boot với Ubuntu, Ubuntu (TTY), Windows 10, timeout 3 giây
# Tham khảo: run-grub-config.sh, setup-grub-boot-ubuntu.sh

set -e

echo "=========================================="
echo "  CẤU HÌNH GRUB - MENU BOOT"
echo "  Ubuntu | Ubuntu (TTY) | Windows 10"
echo "  Timeout: 3 giây"
echo "=========================================="
echo ""

if [ "$EUID" -ne 0 ]; then
    echo "❌ Cần quyền root. Chạy: sudo bash $0"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GRUB_DEFAULT="/etc/default/grub"
GRUB_D_DIR="/etc/grub.d"

# 1. Sao lưu /etc/default/grub
BACKUP_FILE="${GRUB_DEFAULT}.bak-$(date +%F-%H%M%S)"
cp "$GRUB_DEFAULT" "$BACKUP_FILE"
echo "✅ Đã sao lưu: $BACKUP_FILE"
echo ""

# 2. Sửa /etc/default/grub: hiện menu, timeout 3s
echo "📝 Đang cấu hình /etc/default/grub..."

sed -i 's/^GRUB_DEFAULT=.*/GRUB_DEFAULT=0/' "$GRUB_DEFAULT"
sed -i 's/^GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=menu/' "$GRUB_DEFAULT"
sed -i 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=3/' "$GRUB_DEFAULT"

echo "   - GRUB_DEFAULT=0 (mặc định: Ubuntu)"
echo "   - GRUB_TIMEOUT_STYLE=menu (hiện menu)"
echo "   - GRUB_TIMEOUT=3 (3 giây)"
echo ""

# 3. Cài script thêm mục "Ubuntu (TTY)" vào menu
UBUNTU_TTY_SRC="${SCRIPT_DIR}/11_ubuntu-tty"
UBUNTU_TTY_DEST="${GRUB_D_DIR}/11_ubuntu-tty"
if [ -f "$UBUNTU_TTY_SRC" ]; then
    cp "$UBUNTU_TTY_SRC" "$UBUNTU_TTY_DEST"
    chmod +x "$UBUNTU_TTY_DEST"
    echo "✅ Đã thêm mục menu: Ubuntu (TTY) (recovery/console)"
else
    echo "⚠️  Không tìm thấy ${UBUNTU_TTY_SRC}; bỏ qua mục Ubuntu (TTY)."
    echo "   Bạn vẫn có thể chọn Recovery trong 'Advanced options for Ubuntu'."
fi
echo ""

# 4. Cập nhật GRUB
echo "🔄 Đang chạy update-grub..."
update-grub

echo ""
echo "=========================================="
echo "✅ HOÀN TẤT"
echo "=========================================="
echo ""
echo "📌 Menu boot sẽ hiển thị:"
echo "   1. Ubuntu"
echo "   2. Ubuntu (TTY) — chế độ recovery/console"
echo "   3. Advanced options for Ubuntu (các kernel khác)"
echo "   4. Windows 10 (nếu có dual-boot)"
echo ""
echo "📌 Timeout: 3 giây (sau đó boot vào mục mặc định: Ubuntu)"
echo "📌 Backup: $BACKUP_FILE"
echo ""
