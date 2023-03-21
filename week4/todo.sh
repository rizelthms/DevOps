#!/bin/bash

if [[ $1 -eq 1 ]]; then
    docker build -t website-image:latest 1-container
    docker run -d -p9000:9000 --name website-container website-image:latest
elif [[ $1 -eq 2 ]]; then
    docker pull nginx:latest
    docker run --name nginx-static-website --rm -v 1-container:/usr/share/nginx/html -p 8080:80 -d nginx:latest
elif [[ $1 -eq 3 ]]; then
    docker run --name reverseProxy -p 8080:80 -v 2-reverse-proxy:/etc/nginx/conf.d nginx
elif [[ $1 -eq 4 ]]; then
    echo todo4
# TODO: ./todo.sh 4
#       Clone and run the simple-todo-app using an nginx container.
#       Clone the simple-todo-app from https://gitlab.com/sealy/simple-todo-app
#       Navigate to the project folder and create a build distribution (using npm run build)
#       Run an nginx container that has a volume mapping to the build distribution (the dist folder)


elif [[ $1 -eq 5 ]]; then
# TODO: ./todo.sh 5
    docker stop $(docker ps -aq);
    images=("website-image" "devops-primer" "nginx")
    for image in "${images[@]}"; do
        docker rmi $(docker images -q "$image")
    done
fi
