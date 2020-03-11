service php7.3-fpm start
service mysql start
service nginx start

# Create WordPress Database and User with MySQL
mysql -e "
create database mli;
create user mliWP@localhost identified by 'password';
grant all privileges on mli.* to mliWP@localhost;
flush privileges;"

ln -s /etc/nginx/sites-available/wp_config /etc/nginx/sites-enabled/

# Verify nginx setup:
# nginx -t

/bin/sh
# tail -f /dev/null
