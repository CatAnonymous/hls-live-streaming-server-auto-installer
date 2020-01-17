#!/bin/bash

if [[ "$EUID" -ne 0 ]]; then
	echo -e "Sorry, you need to run this as root"
	exit 1
fi

#service nginx stop > /dev/null 2>&1
#service php7.3-fpm stop > /dev/null 2>&1
php /root/php-http-proxy-master/start.php stop -d > /dev/null 2>&1
kill -9 $(lsof -t -i:8880) > /dev/null 2>&1
kill -9 $(lsof -t -i:2052) > /dev/null 2>&1
kill -9 $(lsof -t -i:11371) > /dev/null 2>&1
kill -9 $(lsof -t -i:9000) > /dev/null 2>&1
service nginx start > /dev/null 2>&1
service php7.3-fpm start > /dev/null 2>&1
php /root/php-http-proxy-master/start.php start -d > /dev/null 2>&1
service nginx status
service php7.3-fpm status