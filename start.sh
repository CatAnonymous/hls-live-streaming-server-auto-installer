#!/bin/bash

#sudo service nginx stop > /dev/null 2>&1

#sudo service php7.3-fpm stop > /dev/null 2>&1

sudo php /root/php-http-proxy-master/start.php stop -d > /dev/null 2>&1

sudo kill -9 $(lsof -t -i:8880) > /dev/null 2>&1

sudo kill -9 $(lsof -t -i:2052) > /dev/null 2>&1

sudo kill -9 $(lsof -t -i:11371) > /dev/null 2>&1

sudo kill -9 $(lsof -t -i:9000) > /dev/null 2>&1

sudo service nginx start > /dev/null 2>&1

sudo service php7.3-fpm start > /dev/null 2>&1

sudo php /root/php-http-proxy-master/start.php start -d > /dev/null 2>&1

sudo service nginx status

sudo service php7.3-fpm status
