#!/bin/bash

if [[ "$EUID" -ne 0 ]]; then
	echo -e "Sorry, you need to run this as root"
	exit 1
fi

kill -9 $(lsof -t -i:8880)
kill -9 $(lsof -t -i:2052)
kill -9 $(lsof -t -i:11371)
service nginx start
service php7.3-fpm start
service php7.3-fpm status