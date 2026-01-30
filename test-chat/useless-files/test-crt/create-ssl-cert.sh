#!/bin/bash

DOMAIN=${1:-localhost}
SSL_DIR_KEY="/etc/nginx/ssl/private/"
SSL_DIR_CRT="/etc/nginx/ssl/certs/"
DAYS=${2:-365}

echo "Создаём SSL-сертификат для домена: $DOMAIN"
echo "Срок действия: $DAYS дней"

# Создаём директорию
mkdir -p $SSL_DIR_KEY
mkdir -p $SSL_DIR_CRT

# Генерируем сертификат
openssl req -x509 -nodes -days $DAYS -newkey rsa:2048 \
    -keyout $SSL_DIR_KEY/${DOMAIN}.key \
    -out $SSL_DIR_CRT/${DOMAIN}.crt \
    -subj "/C=JP/ST=Seul/L=City/O=Websocketchat/CN=$DOMAIN"

# Устанавливаем права
chmod 600 $SSL_DIR_KEY/${DOMAIN}.key
chmod 644 $SSL_DIR_CRT/${DOMAIN}.crt

echo "Сертификат создан:"
echo "Ключ: $SSL_DIR_KEY/${DOMAIN}.key"
echo "Сертификат: $SSL_DIR_CRT/${DOMAIN}.crt"
echo "Срок действия до: $(openssl x509 -enddate -noout -in $SSL_DIR_CRT/${DOMAIN}.crt | cut -d= -f2)"
EOF

sudo chmod +x $PWD/create-ssl-cert.sh
