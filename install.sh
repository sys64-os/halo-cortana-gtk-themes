#!/bin/bash
# Halo Cortana Universal Theme Installer (GTK4, GNOME, KDE 6, Kvantum)

THEME_NAME="Halo-Cortana"
echo ">> Memulai instalasi tema $THEME_NAME..."

# Validasi direktori saat ini
if [ ! -d "GTK" ] || [ ! -d "KDE" ]; then
    echo "Error: Harap jalankan script ini di dalam folder hasil ekstraksi."
    exit 1
fi

# Buat folder destinasi user
mkdir -p ~/.themes
mkdir -p ~/.icons
mkdir -p ~/.config/gtk-4.0
mkdir -p ~/.local/share/plasma/look-and-feel
mkdir -p ~/.local/share/aurorae/themes
mkdir -p ~/.config/Kvantum
mkdir -p ~/Pictures/Wallpapers

# Copy Background
if [ -f "background.png" ]; then
    cp background.png ~/Pictures/Wallpapers/halo-cortana-bg.png
    echo ">> Background disalin ke ~/Pictures/Wallpapers/halo-cortana-bg.png"
fi

# 1. Install GTK & GNOME Shell
echo ">> Memasang GTK & GNOME Shell Themes..."
cp -r GTK/$THEME_NAME ~/.themes/
# Khusus GTK4 (Membutuhkan symlink/copy langsung ke ~/.config/gtk-4.0)
cp -rf GTK/$THEME_NAME/gtk-4.0/* ~/.config/gtk-4.0/

# 2. Install KDE Plasma 6 & Aurorae
echo ">> Memasang KDE Plasma 6 Global Theme & Aurorae..."
cp -r KDE/$THEME_NAME-Global ~/.local/share/plasma/look-and-feel/
cp -r KDE/aurorae/$THEME_NAME ~/.local/share/aurorae/themes/

# 3. Install Kvantum
echo ">> Memasang Kvantum Theme..."
cp -r Kvantum/$THEME_NAME ~/.config/Kvantum/

# --- APPLY THEMES ---
echo ">> Menerapkan tema..."

# Deteksi jika menggunakan GNOME
if command -v gsettings &> /dev/null; then
    gsettings set org.gnome.desktop.interface gtk-theme "$THEME_NAME"
    gsettings set org.gnome.desktop.wm.preferences theme "$THEME_NAME"
    
    # Enable GNOME Shell user themes extension & Apply
    gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com 2>/dev/null
    gsettings set org.gnome.shell.extensions.user-theme name "$THEME_NAME"
    
    # Set Icon theme to halo-universe
    gsettings set org.gnome.desktop.interface icon-theme 'halo-universe'
    
    # Force Libadwaita Dark Mode (GTK4 Fix)
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

    # Set Wallpaper (GNOME)
    gsettings set org.gnome.desktop.background picture-uri "file://$HOME/Pictures/Wallpapers/halo-cortana-bg.png"
    gsettings set org.gnome.desktop.background picture-uri-dark "file://$HOME/Pictures/Wallpapers/halo-cortana-bg.png"
    
    echo ">> Tema GNOME & Libadwaita berhasil diterapkan."
fi

# Deteksi jika menggunakan KDE Plasma
if command -v kwriteconfig6 &> /dev/null; then
    echo ">> (KDE 6 Terdeteksi) Untuk menerapkan tema secara penuh, gunakan System Settings."
    echo ">> Buka: Settings -> Global Theme -> Pilih '$THEME_NAME'"
    echo ">> Buka: Settings -> Window Decorations -> Pilih '$THEME_NAME' (Aurorae)"
    echo ">> Buka Kvantum Manager dan aktifkan tema '$THEME_NAME'"
fi

echo "=========================================="
echo ">> Instalasi Selesai!"
echo ">> Jika Anda melihat aplikasi GTK4 atau GNOME Shell belum berubah, silakan Log Out dan Log In kembali."
