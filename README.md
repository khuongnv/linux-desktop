# Linux Desktop – Tổng kết cài đặt & cấu hình

Tài liệu tổng kết các bước và công cụ đã cài đặt/cấu hình cho môi trường Ubuntu desktop.

---

## Môi trường

- **Hệ điều hành:** Ubuntu (kernel 6.8.0-94-generic)
- **Mục đích:** Kiểm tra driver, font, GRUB, gõ tiếng Việt, ứng dụng

---

## Danh sách script & chức năng

| File | Mô tả | Cách chạy |
|------|--------|-----------|
| **check-drivers.sh** | Kiểm tra driver và phần cứng (VGA, WiFi, Ethernet, Audio, Bluetooth, DKMS) | `bash check-drivers.sh` |
| **install-sf-font.sh** | Cài đặt SF Pro Font từ `~/Downloads/SF-Font`, đặt làm font hệ thống mặc định | `bash install-sf-font.sh` |
| **fix-terminal-font.sh** | Chỉnh font terminal (monospace cỡ 12, ưu tiên Ubuntu Mono / SF Pro Text) | `bash fix-terminal-font.sh` |
| **run-grub-config.sh** | Chạy cấu hình GRUB: hiện menu boot, timeout 3s | `bash run-grub-config.sh` (cần sudo) |
| **setup-grub-menu.sh** | Cấu hình GRUB: menu Ubuntu, Ubuntu (TTY), Windows 10, timeout 3 giây | `sudo bash setup-grub-menu.sh` |
| **setup-grub-boot-ubuntu.sh** | Cấu hình GRUB boot thẳng vào Ubuntu (ẩn menu) | `sudo bash setup-grub-boot-ubuntu.sh` |
| **11_ubuntu-tty** | Script thêm mục "Ubuntu (TTY)" (recovery/console) vào menu GRUB | Được gọi tự động bởi `setup-grub-menu.sh` |
| **install-ibus-bamboo.sh** | Cài đặt gõ tiếng Việt với IBus Bamboo (Telex, VNI, VIQR) | `sudo bash install-ibus-bamboo.sh` |
| **install-antigravity.sh** | Cài đặt Antigravity từ `~/Downloads/Antigravity.tar.gz` | `bash install-antigravity.sh` |

---

## Các bước đã thực hiện (tổng kết)

### 1. Kiểm tra driver & phần cứng
- Chạy **check-drivers.sh** để xem VGA, WiFi, Ethernet, Audio, Bluetooth, DKMS.
- Một số mục cần chạy trong terminal thật (hoặc sudo) để tránh lỗi sandbox.

### 2. Font
- **SF Pro Font:** Nguồn tại `~/Downloads/SF-Font`, cài vào `~/.local/share/fonts/SF-Pro`, đặt làm font mặc định (UI, document, monospace, titlebar).
- **Terminal:** Dùng **fix-terminal-font.sh** để đặt monospace cỡ 12 (Ubuntu Mono / SF Pro Text).

### 3. GRUB
- **Menu boot:** Hiện menu với Ubuntu, Ubuntu (TTY), Advanced options, Windows 10 (nếu dual-boot).
- **Timeout:** 3 giây, mặc định boot vào Ubuntu.
- **Ubuntu (TTY):** Mục recovery/console ở cấp top (script **11_ubuntu-tty**).
- Chạy **run-grub-config.sh** hoặc **sudo bash setup-grub-menu.sh** để áp dụng.
- Muốn boot thẳng Ubuntu (ẩn menu): dùng **setup-grub-boot-ubuntu.sh**.

### 4. Gõ tiếng Việt – IBus Bamboo
- PPA: `bamboo-engine/ibus-bamboo`.
- Cài: **sudo bash install-ibus-bamboo.sh**.
- Sau đó: Settings → Region & Language → Input Sources → Add → Vietnamese (Bamboo).
- Chuyển bộ gõ: Super+Space. Hỗ trợ Telex, VNI, VIQR.

### 5. Antigravity
- Cài từ `~/Downloads/Antigravity.tar.gz` bằng **install-antigravity.sh**.
- Cài vào `~/.local/share/Antigravity`, có shortcut trong menu ứng dụng.
- Chạy: menu ứng dụng "Antigravity" hoặc `~/.local/share/Antigravity/antigravity`.

---

## Thứ tự gợi ý khi setup mới

1. **check-drivers.sh** – Kiểm tra driver/phần cứng.
2. **install-sf-font.sh** – Cài SF Pro (cần có sẵn `~/Downloads/SF-Font`).
3. **fix-terminal-font.sh** – Chỉnh font terminal (nếu cần).
4. **sudo bash setup-grub-menu.sh** – Cấu hình menu GRUB (timeout 3s, Ubuntu, Ubuntu TTY, Windows).
5. **sudo bash install-ibus-bamboo.sh** – Cài IBus Bamboo, sau đó thêm Vietnamese (Bamboo) trong Settings.
6. **install-antigravity.sh** – Cài Antigravity (cần có sẵn `~/Downloads/Antigravity.tar.gz`).

---

## Lưu ý

- Script GRUB và IBus Bamboo cần **sudo**.
- Font SF Pro cần thư mục nguồn `~/Downloads/SF-Font`.
- Antigravity cần file `~/Downloads/Antigravity.tar.gz`.
- Sau khi đổi font hoặc GRUB, có thể cần đăng xuất/đăng nhập lại hoặc reboot.
