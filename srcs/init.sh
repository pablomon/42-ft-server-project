service php7.3-fpm start
service nginx start
service mysql start

mysql < db_config.sql

chmod -R 755 /var/www/*

tail -f /dev/null