service php7.3-fpm start
service mysql start
service nginx start

# Create WordPress Database and User with MySQL
mysql -e "
create database wordpress_database;
create user mli@localhost identified by 'password';
grant all privileges on wordpress_database.* to mli@localhost identified by 'password';
grant all privileges on phpmyadmin.* to mli@localhost identified by 'password';
flush privileges;"
mysql wordpress_database < wp_database.sql

# service mysql restart

ln -s /etc/nginx/sites-available/wp_config /etc/nginx/sites-enabled/

# Verify nginx setup:
# nginx -t

# cat /var/www/html/phpmyadmin/config.sample.inc.php

tail -f /dev/null
