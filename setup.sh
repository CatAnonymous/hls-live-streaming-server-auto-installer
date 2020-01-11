#! /bin/bash
#
# Coded by Khai Phan
#
# Email: khaiphan9x@gmail.com
#
# Auto installer RTMP server script for
# Debian and Ubuntu
#
#

clear
mkdir /tmp/nginx-rtmp-build
cd /tmp/nginx-rtmp-build
echo "Ban dang su dung script tu dong cai dat Nginx RTMP cho Debian va Ubuntu duoc viet boi Khai Phan"
echo "================================================"
echo "" 
echo "Dang cap nhat tai nguyen..."
apt-get update > /dev/null 2>&1
apt-get -y upgrade > /dev/null 2>&1
echo ""
echo "Bat dau cai dat NGINX RTMP Server"
echo ""

apt-get -y install build-essential libpcre3 libpcre3-dev libssl-dev zlib1g zlib1g-dev libssl-dev unzip 

wget http://nginx.org/download/nginx-1.17.6.tar.gz && tar -zxvf nginx-1.17.6.tar.gz
wget https://github.com/winshining/nginx-http-flv-module/archive/master.zip && unzip master.zip
cd nginx-1.17.6

./configure --with-http_ssl_module --with-http_stub_status_module --add-module=../nginx-http-flv-module-master --user=www-data --group=www-data --build=KhaiPhan && make && make install

// Install PHP
echo ""
echo "Dang cai dat PHP..."
echo ""
apt-get -y install software-properties-common
apt-get update
apt-get -y install php7.3-fpm php7.3-curl
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.3/fpm/php.ini

// Install FFMPEG
echo ""
echo "Dang cai dat FFMPEG..."
echo ""
apt-get -y install yasm libx264-dev x264 libmp3lame-dev libtheora-dev libvorbis-dev libxvidcore-dev libxext-dev libxfixes-dev ffmpeg

echo ""
echo "Creating file /etc/init.d/nginx"
wget https://raw.githubusercontent.com/khaiphan9x/hls-live-streaming-server-auto-installer/master/nginx-init.txt -O /etc/init.d/nginx > /dev/null 2>&1 && chmod +x /etc/init.d/nginx

echo ""
echo "Creating file /usr/local/nginx/html/.htpasswd"
wget https://raw.githubusercontent.com/khaiphan9x/hls-live-streaming-server-auto-installer/master/.htpasswd -O /usr/local/nginx/html/.htpasswd > /dev/null 2>&1

echo ""
echo "Creating file /usr/local/nginx/html/crossdomain.xml"
wget https://raw.githubusercontent.com/khaiphan9x/hls-live-streaming-server-auto-installer/master/crossdomain.xml -O /usr/local/nginx/html/crossdomain.xml > /dev/null 2>&1

echo ""
echo "Creating file /usr/local/nginx/html/stat.xsl"
wget https://raw.githubusercontent.com/khaiphan9x/hls-live-streaming-server-auto-installer/master/stat.xsl -O /usr/local/nginx/html/stat.xsl > /dev/null 2>&1

echo ""
echo "Creating file /usr/local/nginx/html/info.php"
wget https://raw.githubusercontent.com/khaiphan9x/hls-live-streaming-server-auto-installer/master/info.php -O /usr/local/nginx/html/info.php > /dev/null 2>&1

echo ""
echo "Creating file /usr/local/nginx/html/api.php"
wget https://raw.githubusercontent.com/khaiphan9x/hls-live-streaming-server-auto-installer/master/api.php -O /usr/local/nginx/html/api.php > /dev/null 2>&1

echo ""
echo "Creating file /usr/local/nginx/html/hls.php"
wget https://raw.githubusercontent.com/khaiphan9x/hls-live-streaming-server-auto-installer/master/hls.php -O /usr/local/nginx/html/hls.php > /dev/null 2>&1

echo ""
echo "Creating config file /usr/local/nginx/conf/nginx.conf"
wget https://raw.githubusercontent.com/khaiphan9x/hls-live-streaming-server-auto-installer/master/nginx.conf -O /usr/local/nginx/conf/nginx.conf > /dev/null 2>&1

echo ""
echo "Creating file /root/start.sh"
wget https://raw.githubusercontent.com/khaiphan9x/hls-live-streaming-server-auto-installer/master/start.sh -O /root/start.sh > /dev/null 2>&1 && chmod +x /root/start.sh

mkdir /usr/local/nginx/conf.d
mkdir /tmp/hls
mkdir /tmp/hls2

#service nginx start
#service php7.3-fpm start
#service php7.3-fpm status
bash /root/start.sh

rm -rf /tmp/nginx-rtmp-build
echo ""
echo ""
echo "Da hoan thanh cai dat RTMP Server"
echo "Push to rtmp://IP:11935/live/yourkey"
echo ""
echo "Dang khoi dong lai server..."
echo ""
sleep 5 ; reboot