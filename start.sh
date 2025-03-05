#!/usr/bin/evn bash

docker network create blog
docker container run -d -v blog-database:/var/lib/mysql --name db \
    -e MARINDB_ROOT_PASSWORD=password123 --network blog mariadb
docker container run -d -e PMA_HOST=db -p 9090:80 --rm \
    --network blog --name blog-phpmyadmin phpmyadmin
docker container run -d -p 9091:80 --network blog -v blog-wordpress:/var/www/html \
    --name blog-wordpress -rm wordpress


docker network create my-new-express
docker container run -d \
    --network my-new-express \
    --name express-db \
    -v mongo-express-db:/data/db \
    -e MONGO_INITDB_ROOT_USERNAME=root \
    -e MONGO_INITDB_ROOT_PASSWORD=password123 \
    mongo
docker container run --rm -d \
    -e ME_CONFIG_MONGODB_SERVER=express-db \