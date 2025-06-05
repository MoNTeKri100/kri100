#!/bin/bash

# Скрипт для проверки списка сайтов на наличие ключевых слов

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Список сайтов для проверки (можно добавлять свои)
SITES=(
    "https://4pda.to/forum/index.php?showforum=1192"
    "https://login.amd.com"
    "https://nnm-club-me.ru"
    "https://chatgpt.com"
    "https://www.cisco.com/content/cdc/login.html?referer=/"
)

# Список ключевых слов для поиска (можно добавлять свои)
KEYWORDS=(
    "запрещен"
    "Unable"
    "later"
    "блокировка"
    "Denied"
    "don't"
    "Ошибка"
    "законодательством"
)

# Функция проверки одного сайта
check_site() {
    local url=$1
    echo -e "\n${YELLOW}Проверка сайта: $url${NC}"
    
    # Загружаем содержимое страницы
    local content
    content=$(curl -s -L "$url" 2>/dev/null)
    
    if [ -z "$content" ]; then
        echo -e "${RED}Ошибка: не удалось загрузить страницу${NC}"
        return 1
    fi
    
    # Проверяем каждое ключевое слово
    local found_words=()
    for keyword in "${KEYWORDS[@]}"; do
        if echo "$content" | grep -qi "$keyword"; then
            found_words+=("$keyword")
        fi
    done
    
    # Выводим результаты
    if [ ${#found_words[@]} -gt 0 ]; then
        echo -e "${GREEN}Найдены ключевые слова:${NC}"
        printf '• %s\n' "${found_words[@]}"
    else
        echo -e "${RED}Ключевые слова не найдены${NC}"
    fi
}

# Основной цикл проверки всех сайтов
echo -e "${YELLOW}Начало проверки сайтов...${NC}"
for site in "${SITES[@]}"; do
    check_site "$site"
done
echo -e "\n${YELLOW}Проверка завершена${NC}"
