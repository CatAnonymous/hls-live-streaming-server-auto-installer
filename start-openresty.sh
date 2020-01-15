#!/bin/bash

if [[ "$EUID" -ne 0 ]]; then
	echo -e "Sorry, you need to run this as root"
	exit 1
fi

service openresty start
service php7.3-fpm start
service php7.3-fpm status