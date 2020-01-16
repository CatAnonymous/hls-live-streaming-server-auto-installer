#!/bin/bash

if [[ "$EUID" -ne 0 ]]; then
	echo -e "Sorry, you need to run this as root"
	exit 1
fi

sudo kill -9 $(sudo lsof -t -i:8880)
sudo kill -9 $(sudo lsof -t -i:2052)
sudo kill -9 $(sudo lsof -t -i:11371)
service nginx start
service php7.3-fpm start
service php7.3-fpm status