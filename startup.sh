#!/bin/bash

sed -i "s/^\(FEATURE.*\`msp',\s*\`\[\).*\(\].*\)/\1${MSP:-127.0.0.1}\2/g" /etc/mail/submit.mc
make -C /etc/mail

sed "s/^\(127.0.0.1\s\).*/\1localhost $(hostname) localhost.localdomain/g" /etc/hosts > hosts
cat hosts | tee /etc/hosts

/etc/init.d/httpd start

tail -F /var/log/httpd/access_log
