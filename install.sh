#!/bin/bash
# Halo Cortana Neon Theme Installer (GTK4, GNOME, KDE 6, Kvantum)

THEME_NAME="Halo-Cortana-Neon"
echo ">> Memulai instalasi tema $THEME_NAME (Advanced Neon Edition)..."

# Validasi direktori
if [ ! -d "GTK" ] || [ ! -d "KDE" ]; then
    echo "Error: Harap jalankan script ini di dalam folder hasil ekstraksi."
    exit 1
fi

# Buat folder destinasi
mkdir -p ~/.themes
mkdir -p ~/.icons
mkdir -p ~/.config/gtk-4.0
mkdir -p ~/.local/share/plasma/look-and-feel
mkdir -p ~/.local/share/aurorae/themes
mkdir -p ~/.config/Kvantum
mkdir -p ~/Pictures/Wallpapers

# Copy Background
if [ -f "background.png" ]; then
    cp background.png ~/Pictures/Wallpapers/halo-neon-bg.png
    echo ">> Background disalin ke ~/Pictures/Wallpapers/halo-neon-bg.png"
fi

# 1. Install GTK & GNOME Shell
echo ">> Memasang GTK & GNOME Shell Themes..."
cp -rf GTK/$THEME_NAME ~/.themes/
cp -rf GTK/$THEME_NAME/gtk-4.0/* ~/.config/gtk-4.0/

# 2. Install KDE Plasma 6 & Aurorae
echo ">> Memasang KDE Plasma 6 Global Theme & Aurorae..."
cp -rf KDE/$THEME_NAME-Global ~/.local/share/plasma/look-and-feel/
cp -rf KDE/aurorae/$THEME_NAME ~/.local/share/aurorae/themes/

# 3. Install Kvantum
echo ">> Memasang Kvantum Theme..."
cp -rf Kvantum/$THEME_NAME ~/.config/Kvantum/

# --- APPLY THEMES ---
echo ">> Menerapkan tema..."

if command -v gsettings &> /dev/null; then
    gsettings set org.gnome.desktop.interface gtk-theme "$THEME_NAME"
    gsettings set org.gnome.desktop.wm.preferences theme "$THEME_NAME"
    
    gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com 2>/dev/null
    gsettings set org.gnome.shell.extensions.user-theme name "$THEME_NAME"
    
    gsettings set org.gnome.desktop.interface icon-theme 'halo-universe'
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.background picture-uri "file://$HOME/Pictures/Wallpapers/halo-neon-bg.png"
    gsettings set org.gnome.desktop.background picture-uri-dark "file://$HOME/Pictures/Wallpapers/halo-neon-bg.png"
    
    echo ">> Tema GNOME & Libadwaita Neon berhasil diterapkan."
fi

if command -v kwriteconfig6 &> /dev/null; then
    echo ">> (KDE 6 Terdeteksi) Untuk menerapkan tema secara penuh:"
    echo ">> 1. Buka Settings -> Global Theme -> Pilih '$THEME_NAME'"
    echo ">> 2. Buka Settings -> Window Decorations -> Pilih '$THEME_NAME' (Aurorae)"
    echo ">> 3. Buka Kvantum Manager dan setel tema '$THEME_NAME'"
fi

echo "=========================================="
echo ">> Instalasi Selesai!"
echo ">> Silakan Log Out dan Log In kembali untuk melihat efek Neon Gradient sepenuhnya!"
