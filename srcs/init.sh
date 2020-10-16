service php7.3-fpm start
service nginx start
service mysql start

mysql < db_config.sql

tail -f /dev/null