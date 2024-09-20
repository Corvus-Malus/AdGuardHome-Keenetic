#!/bin/sh

# Цвета для вывода сообщений
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # Без цвета

INSTALL_DIR="/opt/etc/AdGuardHome"
ARCH=$(uname -m)

# Функция определения архитектуры
get_cpu_arch() {
  case "$ARCH" in
    "aarch64" | "arm64")
      echo "arm64"
      ;;
    "armv5" | "armv5l")
      echo "armv5"
      ;;
    "armv6" | "armv6l")
      echo "armv6"
      ;;
    "armv7" | "armv7l")
      echo "armv7"
      ;;
    "x86_64" | "amd64")
      echo "amd64"
      ;;
    "i386" | "i486" | "i686")
      echo "386"
      ;;
    "mips" | "mipsle" | "mips64" | "mips64le")
      if is_little_endian; then
        echo "${ARCH}le"
      else
        echo "${ARCH}"
      fi
      ;;
    *)
      printf "${RED}Неподдерживаемая архитектура: $ARCH${NC}\n" && exit 1
      ;;
  esac
}

# Функция проверки порядка байтов
is_little_endian() {
  printf 'I' | hexdump -o | awk '{ print substr($2, 6, 1); exit; }' | grep -q '1'
}

# Функция для скачивания файла
download_file() {
  local url="$1"
  local output="$2"

  if command -v curl >/dev/null 2>&1; then
    curl -L -o "$output" "$url"
  elif command -v wget >/dev/null 2>&1; then
    wget -O "$output" "$url"
  else
    printf "${RED}Ошибка: не найден curl или wget.${NC}\n" && exit 1
  fi

  # Проверка успешности загрузки
  if [ $? -ne 0 ]; then
    printf "${RED}Ошибка при скачивании файла: $url${NC}\n" && exit 1
  fi
}

install() {
  CPU_ARCH=$(get_cpu_arch)

  # Определение URL для скачивания
  if [[ "$CPU_ARCH" == *"le"* ]]; then
    URL="https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_${CPU_ARCH}_softfloat.tar.gz"
  else
    URL="https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_${CPU_ARCH}.tar.gz"
  fi

  # Скачивание и установка AdGuard Home
  printf "${GREEN}Скачивание и установка AdGuard Home...${NC}\n"
  download_file "$URL" "/opt/etc/AdGuardHome.tar.gz"
  
  # Распаковка и установка
  cd /opt/etc && \
  tar -xzf AdGuardHome.tar.gz && \
  rm AdGuardHome.tar.gz && \
  cd "$INSTALL_DIR" && \
  chmod 755 AdGuardHome && \
  ./AdGuardHome &

  if [ $? -ne 0 ]; then
    printf "${RED}Ошибка при запуске AdGuard Home.${NC}\n" && exit 1
  fi

  # Скачивание и установка файла автозагрузки
  printf "${GREEN}Скачивание и установка файла автозагрузки...${NC}\n"
  download_file "https://github.com/Corvus-Malus/AdGuardHome/raw/main/Installer/S99adguardhome" "/opt/etc/init.d/S99adguardhome"

  chmod +x /opt/etc/init.d/S99adguardhome

  # Задержка перед выводом сообщения об успешной установке
  sleep 3

  printf "${GREEN}Установка завершена.${NC}\n"
}

uninstall() {
  printf "${GREEN}Удаление AdGuard Home и связанных файлов...${NC}\n"

  # Остановка службы
  if [ -f "/opt/etc/init.d/S99adguardhome" ]; then
    printf "${GREEN}Остановка AdGuard Home...${NC}\n"
    /opt/etc/init.d/S99adguardhome stop
    wait # Ждем завершения команды
  else
    printf "${RED}Файл автозагрузки не найден, пропуск остановки.${NC}\n"
  fi

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
