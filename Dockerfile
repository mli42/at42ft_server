# syntax=docker/dockerfile:1.0

FROM debian:buster
WORKDIR /tmp/

# Prerequisites
RUN apt-get update; apt-get upgrade -y; apt-get install wget -y

# Install nginx
RUN apt-get install nginx -y

# Install PHP
RUN apt-get -y install php php-common php-cli php-fpm php-json php-pdo php-mysql \
		php-zip php-gd  php-mbstring php-curl php-xml php-pear php-bcmath

# WordPress requires a database manager.
# In Debian, we have MySQL which is one of the most popular.
# => Install MySQL
RUN apt-get install -y mariadb-server

# Install PHP My Admin
ARG VERSION="4.9.0.1"
RUN wget https://files.phpmyadmin.net/phpMyAdmin/${VERSION}/phpMyAdmin-${VERSION}-all-languages.tar.gz; \
		tar -xf phpMyAdmin-${VERSION}-all-languages.tar.gz; \
		mv phpMyAdmin-${VERSION}-all-languages/ /var/www/html/phpmyadmin

# Install WordPress
RUN wget -c https://wordpress.org/latest.tar.gz; \
		tar -xf latest.tar.gz; \
		mv wordpress /var/www/html/

RUN chown -R www-data:www-data /var/www/html/wordpress/; \
	chmod 755 -R /var/www/html/wordpress/

RUN chown -R www-data:www-data /var/www/html/phpmyadmin; \
	chmod -R 755 /var/www/html/phpmyadmin

COPY ./srcs/wp_config /etc/nginx/sites-available/
COPY ./srcs/wp-config.php /var/www/html/wordpress/
COPY ./srcs/phpmyadmin_config.php /var/www/html/phpmyadmin/config.inc.php
COPY ./srcs/wp_database.sql ./

EXPOSE 80 443

COPY ./srcs/start.sh ./
ENTRYPOINT /bin/sh ./start.sh
