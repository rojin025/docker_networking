#!/usr/bin/evn bash

docker network create blog
docker container run -d -v blog-database:/var/lib/mysql --name db \
    -e MARINDB_ROOT_PASSWORD=password123 --network blog mariadb
docker container run -d -e PMA_HOST=db -p 9090:80 --rm \
    --network blog --name blog-phpmyadmin phpmyadmin
docker container run -d -p 9091:80 --network blog -v blog-wordpress:/var/www/html \
    --name blog-wordpress -rm wordpress
