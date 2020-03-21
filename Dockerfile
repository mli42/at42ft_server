FROM debian:buster
WORKDIR /tmp/

# Prerequisites
RUN apt-get update && apt-get upgrade && apt-get install wget -y
# Install MySQL (MariaDB)
RUN apt-get install -y mariadb-server
# Install PHP
RUN apt-get -y install php php-common php-cli php-fpm php-json php-pdo php-mysql \
	php-zip php-gd  php-mbstring php-curl php-xml php-pear php-bcmath php-intl \
	php-soap php-xmlrpc
# Install nginx
RUN apt-get install -y nginx
# Install WordPress
RUN wget -c https://wordpress.org/latest.tar.gz && \
		tar -xf latest.tar.gz && \
		mv wordpress /var/www/html/
# Install PhpMyAdmin
ARG VERSION="4.9.0.1"
RUN wget https://files.phpmyadmin.net/phpMyAdmin/${VERSION}/phpMyAdmin-${VERSION}-all-languages.tar.gz && \
	tar -xf phpMyAdmin-${VERSION}-all-languages.tar.gz && \
	mv phpMyAdmin-${VERSION}-all-languages/ /var/www/html/phpmyadmin
# Install SSL
RUN apt-get install -y openssl

# Configure MySQL
RUN service mysql start && \
	mysql -u root -e "CREATE DATABASE wordpress_database; \
	CREATE USER 'mli'@'localhost' IDENTIFIED BY 'password'; \
	GRANT ALL PRIVILEGES ON wordpress_database.* TO 'mli'@'localhost' IDENTIFIED BY 'password'; \
	GRANT ALL PRIVILEGES ON phpmyadmin.* TO 'mli'@'localhost' IDENTIFIED BY 'password'; \
	GRANT ALL PRIVILEGES ON *.* TO 'mli'@'localhost' IDENTIFIED BY 'password'; \
	flush privileges;"

# Configure nginx
COPY ./srcs/nginx.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/ && \
	rm -f /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# COPY srcs/default /etc/nginx/sites-available/default

# Configure WordPress
COPY ./srcs/wp-config.php /var/www/html/wordpress/
RUN chown -R www-data:www-data /var/www/html/wordpress/ && \
	chmod -R 777 /var/www/html/wordpress/

# Configure PhpMyAdmin
COPY ./srcs/phpmyadmin_config.php /var/www/html/phpmyadmin/config.inc.php
RUN chown -R www-data:www-data /var/www/html/phpmyadmin && \
	chmod -R 755 /var/www/html/phpmyadmin

# SSL
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj "/C=FR/ST=75/L=Paris/O=42/CN=mli" \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt

EXPOSE 80 443

ENTRYPOINT nginx -t && service php7.3-fpm start && service mysql start && \
		service nginx start && tail -f /dev/null
