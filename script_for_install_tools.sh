#!/bin/bash

# Обновление репозиториев 
sudo apt update

# Функция для проверки установки пакета
check_package_installed() {
    if [ -x "$(command -v $1)" ]; then
        echo "$1 уже установлен."
        return 0
    else
        echo "$1 не установлен."
        return 1
    fi
}

# Функция для установки Go
install_go() {
    if check_package_installed "golang"; then
        return
    fi
    sudo apt install golang 
    go version
}

# Функция для установки Nuclei
install_nuclei() {
    if check_package_installed "nuclei"; then
        return
    fi

    sudo apt install -y nuclei
    nuclei -version
}

# Функция для установки Whois
install_whois() {
    if check_package_installed "whois"; then
        return
    fi

    sudo apt install -y whois
    whois -v
}

# Функция для установки Nmap
install_nmap() {
    if check_package_installed "nmap"; then
        return
    fi
    sudo apt install -y nmap
    nmap --version
}

# Функция для установки HTTPX
install_httpx() {
    if check_package_installed "httpx"; then
        return
    fi

    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
    httpx --version
}

# Функция для установки Subfinder
install_subfinder() {
    if check_package_installed "subfinder"; then
        return
    fi

    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
    subfinder --version
}

# Основной код установки программ для EASM
PS3="Выберите опцию для установки: "
options=("Установить Go" "Установить Nuclei" "Установить Whois" "Установить Nmap" "Установить HTTPX" "Установить Subfinder" "Установить все" "Выйти")
select opt in "${options[@]}"
do
    case $opt in
        "Установить Go")
            install_go
            ;;
        "Установить Nuclei")
            install_nuclei
            ;;
        "Установить Whois")
            install_whois
            ;;
        "Установить Nmap")
            install_nmap
            ;;
        "Установить HTTPX")
            install_httpx
            ;;
        "Установить Subfinder")
            install_subfinder
            ;;
        "Установить все")
            install_go
            install_nuclei
            install_whois
            install_nmap
            install_httpx
            install_subfinder
            ;;
        "Выйти")
            break
            ;;
        *) echo "Некорректная опция $REPLY";;
    esac
done