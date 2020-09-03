#!/bin/bash

sed -i "s/^\(FEATURE.*\`msp',\s*\`\[\).*\(\].*\)/\1${MSP:-127.0.0.1}\2/g" /etc/mail/submit.mc
make -C /etc/mail

/etc/init.d/httpd start

tail -F /var/log/httpd/access_log
