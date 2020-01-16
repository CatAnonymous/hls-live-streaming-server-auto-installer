#!/bin/bash

if [[ "$EUID" -ne 0 ]]; then
	echo -e "Sorry, you need to run this as root"
	exit 1
fi

kill -9 $(lsof -t -i:8880) > /dev/null 2>&1
kill -9 $(lsof -t -i:2052) > /dev/null 2>&1
kill -9 $(lsof -t -i:11371) > /dev/null 2>&1
kill -9 $(lsof -t -i:9000) > /dev/null 2>&1
service nginx start
service php7.3-fpm start
service php7.3-fpm status