#!/bin/bash
# Chạy cấu hình GRUB: hiện menu boot (Ubuntu, Ubuntu TTY, Windows 10), timeout 3s
# Cấu hình chi tiết: setup-grub-menu.sh
# Boot thẳng vào Ubuntu (ẩn menu): setup-grub-boot-ubuntu.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec sudo bash "${SCRIPT_DIR}/setup-grub-menu.sh"
