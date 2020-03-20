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

# Configure MySQL
RUN service mysql start && \
	mysql -u root -e "CREATE DATABASE wordpress_database; \
	CREATE USER 'mli'@'localhost' IDENTIFIED BY 'password'; \
	GRANT ALL PRIVILEGES ON wordpress_database.* TO 'mli'@'localhost' IDENTIFIED BY 'password'; \
	GRANT ALL PRIVILEGES ON phpmyadmin.* TO 'mli'@'localhost' IDENTIFIED BY 'password'; \
	GRANT ALL PRIVILEGES ON *.* TO 'mli'@'localhost' IDENTIFIED BY 'password'; \
	flush privileges;"

# Configure nginx
COPY ./srcs/wordpress /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/

# RUN rm /etc/nginx/sites-available/default
# COPY srcs/default /etc/nginx/sites-available/default

# Configure WordPress
COPY ./srcs/wp-config.php /var/www/html/wordpress/
RUN chown -R www-data:www-data /var/www/html/wordpress/ && \
	chmod -R 777 /var/www/html/wordpress/

ENTRYPOINT nginx -t && service php7.3-fpm start && service mysql start && \
		service nginx start && tail -f /dev/null
