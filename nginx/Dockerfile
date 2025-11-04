FROM nginx:latest

ENV TMP_SITE=websockchat.ru

RUN mkdir -p /var/www/${TMP_SITE}/log/nginx \
             /var/www/${TMP_SITE}/www/vendor-front \
             && rm -f /etc/nginx/conf.d/*


RUN apt update && apt install -y \
    nginx \
    nano

ADD nginx.conf /etc/nginx
ADD websockchat.conf /etc/nginx/conf.d

# Копируем исходники
#ADD ./www/vendor-front /var/www/${TMP_SITE}/www/vendor-front


# Настраиваем права
RUN chown -R www-data:www-data /var/www/${TMP_SITE}
RUN chmod -R 775 /var/www/${TMP_SITE}


CMD ["nginx"]

EXPOSE 80
EXPOSE 443
