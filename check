#!/bin/bash

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Встроенный список сайтов для проверки
SITES=(
    "rutracker.org"
    "telegram.org"
    "example.com"
    "piratebay.org"
)

# Функция проверки доступности сайта
check_site() {
    local site=$1
    
    echo -e "\n${YELLOW}Проверка сайта: $site${NC}"
    
    # 1. Проверка через ping (ICMP)
    echo -n "[ICMP] "
    if ping -c 2 -W 1 "$site" &> /dev/null; then
        echo -e "${GREEN}Доступен${NC}"
    else
        echo -e "${RED}Недоступен${NC}"
    fi
    
    # 2. Проверка через HTTP запрос (curl)
    echo -n "[HTTP] "
    if curl --max-time 5 -s -I "https://$site" | grep -q "HTTP/"; then
        echo -e "${GREEN}Доступен${NC}"
    else
        echo -e "${RED}Недоступен${NC}"
    fi
    
    # 3. Проверка DNS
    echo -n "[DNS] "
    if nslookup "$site" &> /dev/null; then
        echo -e "${GREEN}Запись найдена${NC}"
    else
        echo -e "${RED}Запись не найдена${NC}"
    fi
    
    # 4. Проверка через Tor (если установлен)
    if command -v torsocks &> /dev/null; then
        echo -n "[TOR] "
        if torsocks curl --max-time 10 -s -I "https://$site" | grep -q "HTTP/"; then
            echo -e "${GREEN}Доступен через Tor${NC}"
        else
            echo -e "${RED}Недоступен через Tor${NC}"
        fi
    fi
    
    # 5. Проверка через Google DNS (8.8.8.8)
    echo -n "[Google DNS] "
    if nslookup "$site" 8.8.8.8 &> /dev/null; then
        echo -e "${GREEN}Запись найдена${NC}"
    else
        echo -e "${RED}Запись не найдена${NC}"
    fi
}

# Проверка каждого сайта из списка
for site in "${SITES[@]}"; do
    check_site "$site"
done

echo -e "\n${YELLOW}Проверка завершена${NC}"
echo -e "\n${YELLOW}Проверка завершена${NC}"
