#!/bin/bash
# Cài đặt Antigravity từ file Antigravity.tar.gz trong ~/Downloads
# Cài vào ~/.local/share/Antigravity và tạo shortcut ứng dụng

set -e

SOURCE="$HOME/Downloads/Antigravity.tar.gz"
INSTALL_DIR="$HOME/.local/share/Antigravity"
DESKTOP_DIR="$HOME/.local/share/applications"
BIN_DIR="$HOME/.local/bin"

echo "=========================================="
echo "  CÀI ĐẶT ANTIGRAVITY"
echo "=========================================="
echo ""

if [ ! -f "$SOURCE" ]; then
    echo "❌ Không tìm thấy file: $SOURCE"
    exit 1
fi

echo "📦 Đang giải nén vào $INSTALL_DIR ..."
rm -rf "$INSTALL_DIR"
tar -xzf "$SOURCE" -C "$(dirname "$INSTALL_DIR")"
# Tarball chứa thư mục Antigravity/ → giải nén ra $(dirname $INSTALL_DIR)/Antigravity = $INSTALL_DIR
echo "✅ Đã giải nén"
echo ""

# Cho phép thực thi
chmod +x "$INSTALL_DIR/antigravity" 2>/dev/null || true
[ -f "$INSTALL_DIR/chrome-sandbox" ] && chmod 4755 "$INSTALL_DIR/chrome-sandbox" 2>/dev/null || true

# Tạo shortcut ứng dụng
mkdir -p "$DESKTOP_DIR"
ICON_PATH="$INSTALL_DIR/resources/app/out/media/code-icon.svg"
[ ! -f "$ICON_PATH" ] && ICON_PATH="$INSTALL_DIR/resources/app/out/media/apple-dark.svg"
[ ! -f "$ICON_PATH" ] && ICON_PATH="application-x-executable"

cat > "$DESKTOP_DIR/antigravity.desktop" << EOF
[Desktop Entry]
Name=Antigravity
Comment=Antigravity Editor
Exec=$INSTALL_DIR/antigravity %F
Icon=$ICON_PATH
Type=Application
Categories=Development;TextEditor;
StartupNotify=true
StartupWMClass=Antigravity
EOF

echo "✅ Đã tạo shortcut ứng dụng"
echo ""

# Symlink vào ~/.local/bin nếu có
if [ -d "$BIN_DIR" ]; then
    ln -sf "$INSTALL_DIR/antigravity" "$BIN_DIR/antigravity"
    echo "✅ Đã thêm lệnh: $BIN_DIR/antigravity"
fi

echo "=========================================="
echo "✅ HOÀN TẤT"
echo "=========================================="
echo ""
echo "📌 Chạy Antigravity:"
echo "   - Từ menu ứng dụng (tìm 'Antigravity')"
echo "   - Hoặc: $INSTALL_DIR/antigravity"
echo "   - Hoặc: antigravity (nếu ~/.local/bin đã có trong PATH)"
echo ""
