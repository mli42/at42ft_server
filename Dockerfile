# syntax=docker/dockerfile:1.0

FROM debian:buster
WORKDIR /tmp/

# Prerequisites
RUN apt-get update; apt-get upgrade -y; apt-get install ufw -y
RUN apt-get install wget -y

# Install nginx
RUN apt-get install sudo -y
RUN apt-get install nginx -y
#RUN sudo ufw allow 'Nginx HTTP'

RUN apt-get install systemd -y

# Install PHP
RUN apt-get -y install php php-common

#RUN apt-get -y install php-cli php-fpm php-json php-pdo php-mysql php-zip php-gd  php-mbstring php-curl php-xml php-pear php-bcmath

# WordPress requires a database manager.
# In Debian, we have MySQL which is one of the most popular.
# => Install MySQL
RUN apt-get install default-mysql-server -y

# Install PHP My Admin
ARG VERSION="4.9.0.1"
RUN wget https://files.phpmyadmin.net/phpMyAdmin/${VERSION}/phpMyAdmin-${VERSION}-all-languages.tar.gz
RUN tar -xf phpMyAdmin-${VERSION}-all-languages.tar.gz; mv phpMyAdmin-${VERSION}-all-languages/ /var/www/html/phpMyAdmin

# Install WordPress
RUN wget -c https://wordpress.org/latest.tar.gz; tar -xf latest.tar.gz; mv wordpress /var/www/html/

# RUN chown -R www-data:www-data /var/www/html/wordpress/
# RUN chmod 755 -R /var/www/html/wordpress/

ENTRYPOINT php -v
