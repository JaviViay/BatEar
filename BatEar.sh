#!/bin/bash

# Colors ANSI
BLUE='\033[0;34m'
RED='\033[0;31m'
GREEN='\033[0;32m'
RESET_COLOR='\033[0m'

# Banner en azul
echo -e "${BLUE} ___       _     ___          "
echo "| _ ) __ _| |_  | __|__ _ _ _ "
echo "| _ \/ _  |  _| | _|/ _  | '_|"
echo -e "|___/\__,_|\__| |___\__,_|_|  ${RESET_COLOR}"
echo -e "${RED}[*]21 FTP   [*]22 SSH   [*]23 Telnet"
echo -e "[*]53 DNS   [*]80 HTTP  [*]443 HTTPS${RESET_COLOR}"

# Catch my IP
my_ip=$(hostname -I | cut -d' ' -f1)

# Check for superuser privileges
if [ "$EUID" -ne 0 ]; then
  echo "Este script debe ejecutarse como superusuario (root)." 
  exit 1
fi

# Check port
tcpdump -i any -n -q -l "port $1" 2>/dev/null | while read line; do
  ip=$(echo "$line" | grep -oP '(\d+\.\d+\.\d+\.\d+)' | head -1)
  if [ -n "$ip" ] && [ "$ip" != "$my_ip" ]; then
    echo -e "Incoming traffic from port ${RED}$1${RESET_COLOR} and IP ${GREEN}$ip${RESET_COLOR}"
  fi
done