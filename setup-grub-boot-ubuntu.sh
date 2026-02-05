#!/bin/bash
# Script để cấu hình GRUB boot thẳng vào Ubuntu (không hiện menu)

set -e  # Dừng nếu có lỗi

echo "=========================================="
echo "Cấu hình GRUB để boot thẳng vào Ubuntu"
echo "=========================================="
echo ""

# Kiểm tra quyền root
if [ "$EUID" -ne 0 ]; then 
    echo "❌ Script này cần quyền sudo. Vui lòng chạy:"
    echo "   sudo bash $0"
    exit 1
fi

# Sao lưu file cấu hình GRUB
BACKUP_FILE="/etc/default/grub.bak-$(date +%F-%H%M%S)"
cp /etc/default/grub "$BACKUP_FILE"
echo "✅ Đã sao lưu cấu hình GRUB tại: $BACKUP_FILE"
echo ""

# Đảm bảo các giá trị đúng để boot thẳng vào Ubuntu
echo "📝 Đang cấu hình GRUB..."

# Đảm bảo GRUB_DEFAULT=0 (boot vào mục đầu tiên = Ubuntu)
sed -i 's/^GRUB_DEFAULT=.*/GRUB_DEFAULT=0/' /etc/default/grub

# Đảm bảo GRUB_TIMEOUT_STYLE=hidden (ẩn menu)
sed -i 's/^GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=hidden/' /etc/default/grub

# Đảm bảo GRUB_TIMEOUT=0 (không chờ, boot ngay)
sed -i 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=0/' /etc/default/grub

echo "✅ Đã cấu hình:"
echo "   - GRUB_DEFAULT=0 (boot vào Ubuntu)"
echo "   - GRUB_TIMEOUT_STYLE=hidden (ẩn menu)"
echo "   - GRUB_TIMEOUT=0 (boot ngay, không chờ)"
echo ""

# Cập nhật GRUB
echo "🔄 Đang cập nhật cấu hình GRUB..."
update-grub

echo ""
echo "=========================================="
echo "✅ Hoàn tất! Cấu hình đã được áp dụng."
echo "=========================================="
echo ""
echo "📌 Lưu ý:"
echo "   - Máy sẽ boot thẳng vào Ubuntu khi khởi động"
echo "   - Nếu muốn vào menu GRUB, nhấn và giữ phím SHIFT khi boot"
echo "   - File backup: $BACKUP_FILE"
echo ""
