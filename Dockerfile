FROM debian:buster

RUN apt-get update

# php
#RUN apt-get install -y php php-fpm php-gd php-mysql php-cli php-curl php-json 
RUN apt-get install -y php-fpm php-mysql php-mbstring

# nginx 
RUN apt-get -y install nginx
COPY ./srcs/pmontese.crt /etc/ssl/pmontese.crt
COPY ./srcs/pmontese.key /etc/ssl/pmontese.key
COPY ./srcs/ngnix-config /etc/nginx/sites-available/default
COPY ./srcs/disable_autoindex.sh /
COPY ./srcs/enable_autoindex.sh /

# mysql
RUN apt-get -y install mariadb-server
COPY ./srcs/db_config.sql /db_config.sql

# phpmyadmin
COPY ./srcs/phpMyAdmin-5.0.4-english.tar.gz /
RUN tar zxf phpMyAdmin-5.0.4-english.tar.gz && \
	rm phpMyAdmin-5.0.4-english.tar.gz && \
	mv phpMyAdmin-5.0.4-english  /var/www/html/phpmyadmin
COPY ./srcs/config.inc.php /var/www/html/phpmyadmin

# wordpress
COPY ./srcs/wordpress-5.5.1.tar.gz /
RUN	tar zxf wordpress-5.5.1.tar.gz && \
	rm wordpress-5.5.1.tar.gz && \
	mv wordpress /var/www/html/wordpress
COPY ./srcs/wp-config.php /var/www/html/wordpress

# start services
COPY ./srcs/init.sh init.sh
CMD ["bash", "./init.sh"]

EXPOSE 80
EXPOSE 443