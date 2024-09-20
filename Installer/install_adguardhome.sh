#!/bin/sh

# Цвета для вывода сообщений
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # Без цвета

INSTALL_DIR="/opt/etc/AdGuardHome"
ARCH=$(uname -m)

# Если доступна команда lscpu, используем её для более детального определения архитектуры
if command -v lscpu > /dev/null; then
  CPU_ARCH=$(lscpu | grep Architecture | awk '{print $2}')
else
  CPU_ARCH=$ARCH
fi

install() {
  case $CPU_ARCH in
    "aarch64")
      URL="https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_arm64.tar.gz"
      ;;
    "armv5")
      URL="https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_armv5.tar.gz"
      ;;
    "armv6")
      URL="https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_armv6.tar.gz"
      ;;
    "armv7")
      URL="https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_armv7.tar.gz"
      ;;
    "mipsle" | "mipsel")
      URL="https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_mipsle_softfloat.tar.gz"
      ;;
    "mips64le")
      URL="https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_mips64le_softfloat.tar.gz"
      ;;
    "mips")
      URL="https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_mips_softfloat.tar.gz"
      ;;
    "amd64" | "x86_64")
      URL="https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_amd64.tar.gz"
      ;;
    *)
      printf "${RED}Неподдерживаемая архитектура: $CPU_ARCH${NC}\n" && exit 1
      ;;
  esac

  # Скачивание и установка AdGuard Home
  printf "${GREEN}Скачивание и установка AdGuard Home...${NC}\n"
  curl -L -o /opt/etc/AdGuardHome.tar.gz $URL
  if [ $? -ne 0 ]; then
    printf "${RED}Ошибка при скачивании AdGuard Home.${NC}\n" && exit 1
  fi

  cd /opt/etc && \
  tar -xzf AdGuardHome.tar.gz && \
  rm AdGuardHome.tar.gz && \
  cd $INSTALL_DIR && \
  chmod 755 AdGuardHome && \
  ./AdGuardHome &
  if [ $? -ne 0 ]; then
    printf "${RED}Ошибка при запуске AdGuard Home.${NC}\n" && exit 1
  fi

  # Скачивание и установка файла автозагрузки
  printf "${GREEN}Скачивание и установка файла автозагрузки...${NC}\n"
  curl -L -o /opt/etc/init.d/S99adguardhome https://github.com/Corvus-Malus/AdGuardHome/raw/main/Installer/S99adguardhome
  if [ $? -ne 0 ]; then
    printf "${RED}Ошибка при скачивании файла автозагрузки.${NC}\n" && exit 1
  fi

  chmod +x /opt/etc/init.d/S99adguardhome

  printf "${GREEN}Установка завершена.${NC}\n"
}

uninstall() {
  printf "${GREEN}Удаление AdGuard Home и связанных файлов...${NC}\n"

  # Удаление установленных файлов
  if [ -d "$INSTALL_DIR" ]; then
    rm -rf "$INSTALL_DIR"
    printf "${GREEN}Удален $INSTALL_DIR${NC}\n"
  else
    printf "${RED}AdGuard Home не найден в $INSTALL_DIR${NC}\n"
  fi

  # Удаление файла автозагрузки
  if [ -f "/opt/etc/init.d/S99adguardhome" ]; then
    rm /opt/etc/init.d/S99adguardhome
    printf "${GREEN}Удален /opt/etc/init.d/S99adguardhome${NC}\n"
  else
    printf "${RED}Файл автозагрузки не найден${NC}\n"
  fi

  printf "${GREEN}Удаление завершено.${NC}\n"
}

# Проверка аргументов командной строки
if [ "$1" = "install" ]; then
  install
elif [ "$1" = "uninstall" ]; then
  uninstall
else
  printf "${RED}Использование: $0 {install|uninstall}${NC}\n"
  exit 1
fi
