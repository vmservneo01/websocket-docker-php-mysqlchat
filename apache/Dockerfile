FROM php:8-apache
#установим переменную окружения для работы с конфигом apache
ENV TMP_SITE=websockchat.ru

# Устанавливаем системные зависимости и supervisord
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    nano \
    unzip \
    supervisor \
    iproute2 \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/* \
    && rm -rf /var/log/apt\
    && rm -rf /root/.cache 

# Настраиваем PHP расширения
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql mysqli

# Установка Composer для поднятия зависимостей сборки
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
&& composer --version

# Включаем Apache модули
RUN a2enmod rewrite ssl headers remoteip setenvif proxy proxy_wstunnel
# mpm_prefork    && \
#    a2dismod mpm_event 

# Копируем виртуальные хосты и все содержимое для работы на apache2
RUN mkdir -p /tmpdir \  
             /var/www/websockchat.ru/log/apache \
             /var/www/websockchat.ru/www 

#Помимо копирования виртуального хоста, скопируем еще .conf supervisor
COPY vhosts /tmpdir 
COPY ./supervisor/websocket.conf /etc/supervisor/conf.d
COPY ./vhosts/websockchat.ru.conf /etc/apache2/sites-enabled/$TMP_SITE.conf

RUN   mv /tmpdir/ports.conf /etc/apache2/ && \
      mv /tmpdir/dir.conf /etc/apache2/mods-available/ && \
      sed -i '182r /tmpdir/apache2.conf'  /etc/apache2/apache2.conf && \
      mv /tmpdir/remoteip.conf /etc/apache2/mods-available/ && \
      rm -rf /tmpdir

######
#####  на разворачивании в yandexcloud не работает RUN cat поэтому просто добавим туда файл 
####
#RUN cat <<EOF > /etc/apache2/sites-enabled/$TMP_SITE.conf
#<VirtualHost *:9000>
#    Define root_domain ${TMP_SITE}
#    Define root_path /var/www/${TMP_SITE}
#
#    ServerName \${root_domain}
#    ServerAlias www.\${root_domain}
#    DocumentRoot \${root_path}/www
#
#    ErrorLog     \${root_path}/log/apache/error_log
#    TransferLog  \${root_path}/log/apache/access_log
#
#</VirtualHost>
#EOF

# Активируем сайт(у меня не работает эта строка)
#RUN a2ensite websockchat.ru.conf 

# Копируем исходники
ADD ./www /var/www/websockchat.ru/www

#Переход в директорию и установка зависимостей
WORKDIR /var/www/websockchat.ru/www
RUN composer install  --no-dev --optimize-autoloader
WORKDIR /

# Настраиваем права
RUN chown -R www-data:www-data /var/www/websockchat.ru
RUN chmod -R 775 /var/www/websockchat.ru/


EXPOSE 9000
CMD ["supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]

