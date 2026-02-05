#!/bin/bash
# Chỉnh font terminal cho dễ đọc: monospace cỡ 12, ưu tiên font hiển thị tốt trên Linux

echo "=========================================="
echo "  CHỈNH FONT TERMINAL"
echo "=========================================="
echo ""

# Font monospace cỡ 12 — ưu tiên font dễ đọc trong terminal
# Thử lần lượt: Ubuntu Mono (sẵn trên Ubuntu), SF Pro Text (nếu đã cài), JetBrains Mono
if fc-list | grep -qi "Ubuntu Mono"; then
    gsettings set org.gnome.desktop.interface monospace-font-name "Ubuntu Mono 12"
    echo "✅ Đã đặt font terminal: Ubuntu Mono 12"
elif fc-list | grep -qi "SF Pro Text"; then
    gsettings set org.gnome.desktop.interface monospace-font-name "SF Pro Text 12"
    echo "✅ Đã đặt font terminal: SF Pro Text 12"
elif fc-list | grep -qi "JetBrains Mono"; then
    gsettings set org.gnome.desktop.interface monospace-font-name "JetBrains Mono 12"
    echo "✅ Đã đặt font terminal: JetBrains Mono 12"
else
    gsettings set org.gnome.desktop.interface monospace-font-name "Monospace 12"
    echo "✅ Đã đặt font terminal: Monospace 12"
fi

echo ""
echo "📌 Mở lại terminal (hoặc tab mới) để thấy font mới."
echo "📌 Muốn dùng font khác, chạy:"
echo "   gsettings set org.gnome.desktop.interface monospace-font-name \"Tên Font 12\""
echo ""
