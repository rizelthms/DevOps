#!/bin/bash

# TODO: ./todo.sh 1
docker build -t website-image:latest 1-container;
docker run -d -p9000:9000 --name website-container website-image:latest;


# TODO: ./todo.sh 2
#       Serve static content using a standard nginx container. 
#       Give the image a proper name (or tag) using the -t flag.
#       Create a volume mapping to serve the static web site located in 1-container.


# TODO: ./todo.sh 3
docker run -d \
    -it \
    -v "$PWD"/www:/www:ro \
    -v "$PWD"/conf.d:/etc/nginx/conf.d:ro \
    -p 8080:80 \
    nginx:latest


# TODO: ./todo.sh 4
#       Clone and run the simple-todo-app using an nginx container.
#       Clone the simple-todo-app from https://gitlab.com/sealy/simple-todo-app
#       Navigate to the project folder and create a build distribution (using npm run build)
#       Run an nginx container that has a volume mapping to the build distribution (the dist folder)


# TODO: ./todo.sh 5
#       Clean up your stuff.
#       Stop all your containers (so other containers should not be stopped)
#       Remove your images (please leave the other images alone)
