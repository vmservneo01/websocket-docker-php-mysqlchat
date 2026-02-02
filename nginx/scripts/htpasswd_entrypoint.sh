# Create Kibana username and password into htpasswd file
KIBANA_USERNAME=${KIBANA_USERNAME:-admin}
KIBANA_PASSWORD=${KIBANA_PASSWORD:-admin}
HTPASSWD_FILE="/etc/nginx/conf.d/kibana.htpasswd"
if [ -f $HTPASSWD_FILE ] ; then
    rm $HTPASSWD_FILE
fi
htpasswd -c -b ${HTPASSWD_FILE} ${KIBANA_USERNAME} ${KIBANA_PASSWORD}

