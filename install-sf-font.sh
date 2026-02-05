#!/bin/bash
# Script cài đặt SF Pro Font và đặt làm font hệ thống mặc định

set -e

FONT_SOURCE="/home/khuongnv/Downloads/SF-Font"
FONT_DEST="$HOME/.local/share/fonts/SF-Pro"

echo "=========================================="
echo "  CÀI ĐẶT SF PRO FONT CHO HỆ THỐNG"
echo "=========================================="
echo ""

# Kiểm tra thư mục nguồn
if [ ! -d "$FONT_SOURCE" ]; then
    echo "❌ Không tìm thấy thư mục font: $FONT_SOURCE"
    exit 1
fi

# Đếm số file font
FONT_COUNT=$(find "$FONT_SOURCE" -type f \( -name "*.ttf" -o -name "*.otf" -o -name "*.ttc" \) | wc -l)
echo "📦 Tìm thấy $FONT_COUNT file font trong $FONT_SOURCE"
echo ""

# Tạo thư mục đích
echo "📁 Tạo thư mục font: $FONT_DEST"
mkdir -p "$FONT_DEST"

# Copy font
echo "📋 Đang copy font..."
cp -r "$FONT_SOURCE"/* "$FONT_DEST"/
echo "✅ Đã copy $FONT_COUNT file font"
echo ""

# Cập nhật font cache
echo "🔄 Đang cập nhật font cache..."
fc-cache -fv "$FONT_DEST" 2>&1 | grep -i "cache\|font" | head -5
echo "✅ Font cache đã được cập nhật"
echo ""

# Kiểm tra font đã được cài đặt
echo "🔍 Kiểm tra font đã được cài đặt:"
fc-list | grep -i "SF Pro\|San Francisco" | head -3
echo ""

# Lấy tên font chính xác từ font cache
FONT_NAME=$(fc-list | grep -i "SF Pro" | grep -i "Regular\|Text Regular" | head -1 | cut -d: -f2 | awk '{print $1}' | tr -d ',')

if [ -z "$FONT_NAME" ]; then
    # Thử tìm với tên khác
    FONT_NAME=$(fc-list | grep -i "SF Pro" | head -1 | cut -d: -f2 | awk '{print $1}' | tr -d ',')
fi

if [ -z "$FONT_NAME" ]; then
    echo "⚠️  Không tìm thấy tên font chính xác, sẽ dùng 'SF Pro'"
    FONT_NAME="SF Pro"
else
    echo "✅ Tìm thấy font: $FONT_NAME"
fi
echo ""

# Hiển thị font hiện tại
CURRENT_FONT=$(gsettings get org.gnome.desktop.interface font-name | tr -d "'")
echo "📝 Font hiện tại: $CURRENT_FONT"
echo ""

# Đặt font mặc định
echo "⚙️  Đang đặt font hệ thống..."

# Font mặc định (UI)
if [ ! -z "$FONT_NAME" ]; then
    # Thử với tên đầy đủ
    gsettings set org.gnome.desktop.interface font-name "$FONT_NAME 11" 2>/dev/null || \
    gsettings set org.gnome.desktop.interface font-name "SF Pro Text 11" 2>/dev/null || \
    gsettings set org.gnome.desktop.interface font-name "SF Pro Display 11" 2>/dev/null || \
    echo "⚠️  Không thể đặt font với tên tự động, vui lòng chọn thủ công"
    
    echo "✅ Đã đặt font mặc định"
fi

# Font monospace (terminal, code editor) — cỡ 12 cho dễ đọc
gsettings set org.gnome.desktop.interface monospace-font-name "SF Mono 12" 2>/dev/null || \
gsettings set org.gnome.desktop.interface monospace-font-name "SF Pro Text 12" 2>/dev/null || \
echo "⚠️  Không tìm thấy SF Mono/SF Pro Text, giữ nguyên font monospace hiện tại"

# Font document
gsettings set org.gnome.desktop.interface document-font-name "$FONT_NAME 11" 2>/dev/null || \
gsettings set org.gnome.desktop.interface document-font-name "SF Pro Text 11" 2>/dev/null || \
echo "⚠️  Không thể đặt document font"

# Font window title
gsettings set org.gnome.desktop.wm.preferences titlebar-font "$FONT_NAME Bold 11" 2>/dev/null || \
gsettings set org.gnome.desktop.wm.preferences titlebar-font "SF Pro Display Bold 11" 2>/dev/null || \
echo "⚠️  Không thể đặt titlebar font"

echo ""
echo "=========================================="
echo "✅ HOÀN TẤT!"
echo "=========================================="
echo ""
echo "📌 Font đã được cài đặt tại: $FONT_DEST"
echo "📌 Font đã được đặt làm mặc định cho hệ thống"
echo ""
echo "💡 Lưu ý:"
echo "   - Bạn có thể cần đăng xuất và đăng nhập lại để áp dụng đầy đủ"
echo "   - Hoặc khởi động lại các ứng dụng đang chạy"
echo ""
echo "🔧 Để kiểm tra/đổi font thủ công:"
echo "   - Mở Settings > Appearance > Fonts"
echo "   - Hoặc chạy: gnome-tweaks"
echo ""
echo "📋 Để xem danh sách font SF Pro đã cài:"
echo "   fc-list | grep -i 'SF Pro'"
echo ""
