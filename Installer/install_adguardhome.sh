#!/bin/sh

INSTALL_DIR="/opt/etc/AdGuardHome"
ARCH=$(uname -m)

install() {
  case $ARCH in
    "aarch64") URL="https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_arm64.tar.gz" ;;
    "mipsle") URL="https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_mipsle_softfloat.tar.gz" ;;
    "mips") URL="https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_mips_softfloat.tar.gz" ;;
    *) echo "Unsupported architecture: $ARCH" && exit 1 ;;
  esac

  # Скачивание и установка AdGuard Home
  curl -L -o /opt/etc/AdGuardHome.tar.gz $URL && \
  cd /opt/etc && \
  tar -xzf AdGuardHome.tar.gz && \
  rm AdGuardHome.tar.gz && \
  cd $INSTALL_DIR && \
  chmod 755 AdGuardHome && \
  ./AdGuardHome &

  # Скачивание и установка файла автозагрузки
  curl -L -o /opt/etc/init.d/S99adguardhome https://github.com/Corvus-Malus/AdGuardHome/raw/main/Installer/S99adguardhome && \
  chmod +x /opt/etc/init.d/S99adguardhome

  echo "Installation complete."
}

uninstall() {
  echo "Removing AdGuard Home and related files..."

  # Удаление установленных файлов
  if [ -d "$INSTALL_DIR" ]; then
    rm -rf "$INSTALL_DIR"
    echo "Removed $INSTALL_DIR"
  else
    echo "AdGuard Home not found in $INSTALL_DIR"
  fi

  # Удаление файла автозагрузки
  if [ -f "/opt/etc/init.d/S99adguardhome" ]; then
    rm /opt/etc/init.d/S99adguardhome
    echo "Removed /opt/etc/init.d/S99adguardhome"
  else
    echo "Autostart file not found"
  fi

  echo "Uninstallation complete."
}

# Проверка аргументов командной строки
if [ "$1" = "install" ]; then
  install
elif [ "$1" = "uninstall" ]; then
  uninstall
else
  echo "Usage: $0 {install|uninstall}"
  exit 1
fi