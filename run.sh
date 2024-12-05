#!/bin/bash

# Start MongoDB container
docker run -d --name mongodb -v ~/lasttime/database/init.js:/docker-entrypoint-initdb.d/init.js -p 27017:27017 mongo:latest

# Wait for MongoDB to start
sleep 5

# Start Express container
docker build -t express ~/lasttime/express
docker run -d --name express --link mongodb -p 3000:3000 express

# Start Nginx container
docker run -d --name nginx -p 8080:80 -v ~/lasttime/nginx/nginx.conf:/etc/nginx/nginx.conf --link express nginx

