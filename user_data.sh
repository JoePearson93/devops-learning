#!/bin/bash
set -euo pipefail
exec > /var/log/user-data.log 2>&1

apt-get update -y
apt-get install -y apache2 php php-mysql php-fpm php-json php-mbstring php-xml php-gd php-curl mariadb-server wget

systemctl enable --now apache2
systemctl enable --now mariadb

DB_NAME="wordpress"
DB_USER="wpuser"
DB_PASS="${db_pass}"

mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';"
mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
mysql -u root -e "FLUSH PRIVILEGES;"

wget -q https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz
tar -xzf /tmp/wordpress.tar.gz -C /tmp
cp -r /tmp/wordpress/* /var/www/html/
rm -f /var/www/html/index.html

cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

sed -i "s/database_name_here/$DB_NAME/" /var/www/html/wp-config.php
sed -i "s/username_here/$DB_USER/"      /var/www/html/wp-config.php
sed -i "s/password_here/$DB_PASS/" /var/www/html/wp-config.php

chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/

echo "WordPress setup complete"