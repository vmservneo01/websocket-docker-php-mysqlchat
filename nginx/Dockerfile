FROM nginx:latest

ENV TMP_SITE=websockchat.ru

RUN mkdir -p /var/www/${TMP_SITE}/log/nginx \
             /var/www/${TMP_SITE}/www/vendor-front \
             /scripts \
             && rm -f /etc/nginx/conf.d/*


RUN apt update && apt install -y \
    nginx \
    nano \
    openssl &&\
    apt-get autoremove -y && \
    apt-get clean


ADD nginx.conf ssl-params.conf /etc/nginx/
ADD websockchat.conf /etc/nginx/conf.d
ADD scripts/* /scripts/
# Копируем исходники
#ADD ./www/vendor-front /var/www/${TMP_SITE}/www/vendor-front


# Настраиваем права
RUN chown -R www-data:www-data /var/www/${TMP_SITE}
RUN chmod -R 775 /var/www/${TMP_SITE}
RUN chmod +x /scripts/*.sh
RUN /scripts/create-ssl-cert-for-nginx.sh websockchat.ru 365
RUN /scripts/create-ssl-cert-for-elk.sh elk.digitalagro.ru  365

#CMD ["/create-ssl-cert.sh","websockchat.ru","365"]
CMD ["/bin/bash", "/scripts/htpasswd_entrypoint.sh"]

#EXPOSE 80
EXPOSE 443
