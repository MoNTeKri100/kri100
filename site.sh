#!/bin/bash

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Список сайтов для проверки
SITES=(
   "https://4pda.to/forum/index.php?showforum=1192"
    "https://login.amd.com"
    "https://nnm-club-me.ru"
    "https://chatgpt.com"
    "https://www.cisco.com/content/cdc/login.html?referer=/"
)

# Список ключевых слов (опасные или искомые)
KEYWORDS=(
   "запрещен"
    "Unable"
    "later"
    "блокировка"
    "Denied"
    "don't"
    "Ошибка"
    "законодательством"
    "перемещена"
    "удалена"
)

# Функция проверки сайта
check_site() {
    local url=$1
    echo -e "\n${YELLOW}🔎 Проверка: $url${NC}"
    
    local content
    content=$(curl -s -L "$url" 2>/dev/null)
    
    if [ -z "$content" ]; then
        echo -e "${RED}❌ Ошибка загрузки${NC}"
        return
    fi

    local found_words=()
    for keyword in "${KEYWORDS[@]}"; do
        if echo "$content" | grep -qi "$keyword"; then
            found_words+=("$keyword")
        fi
    done

    if [ ${#found_words[@]} -gt 0 ]; then
        echo -e "${RED}⚠️ Найдены запрещенные слова:${NC}"
        printf "• ${RED}%s${NC}\n" "${found_words[@]}"
    else
        echo -e "${GREEN}✅ Безопасно: запрещенные слова не обнаружены${NC}"
    fi
}

# Запуск проверки
echo -e "${YELLOW}🚀 Начало сканирования...${NC}"
for site in "${SITES[@]}"; do
    check_site "$site"
done
echo -e "\n${YELLOW}🔚 Проверка завершена${NC}"
