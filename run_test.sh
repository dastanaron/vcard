#!/usr/bin/env bash

docker network create vcard-lib-network

docker build -t vcard-lib-test .

docker stop vcard-lib-test || true
docker rm vcard-lib-test || true

docker run -d --network vcard-lib-network --restart=always --name vcard-lib-test vcard-lib-test:latest

docker exec vcard-lib-test composer install

#docker exec vcard-lib-test /var/www/html/vendor/bin/phpunit
docker exec vcard-lib-test composer run-script test

docker stop vcard-lib-test || true
docker rm vcard-lib-test || true
