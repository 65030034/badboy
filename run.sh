#!/bin/bash

# Start MongoDB container
docker run -d --name mongodbforjing -v ~/lasttime/database/init.js:/docker-entrypoint-initdb.d/init.js -p 27017:27017 mongo:latest

# Wait for MongoDB to start
sleep 5

# Start Express container
docker build -t expressforjing ~/lasttime/express
docker run -d --name expressforjing --link mongodbforjing -p 3000:3000 expressforjing

# Start Nginx container
docker run -d --name nginxforjing -p 8080:80 -v ~/lasttime/nginx/nginx.conf:/etc/nginx/nginx.conf --link expressforjing nginx

