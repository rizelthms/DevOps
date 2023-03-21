#!/bin/bash

if [[ $1 -eq 1 ]]; then
    docker build -t website-image:latest 1-container
    docker run -d -p9000:9000 --name website-container website-image:latest
elif [[ $1 -eq 2 ]]; then
    docker pull nginx:latest
    docker run --name nginx-static-website -v "$(pwd)/1-container":"/usr/share/nginx/html" -p 8080:80 -d nginx:latest
elif [[ $1 -eq 3 ]]; then
    docker run --name reverseProxy -p 8080:80 -v 2-reverse-proxy:/etc/nginx/conf.d nginx
elif [[ $1 -eq 4 ]]; then
cd 4-complete/frontend
git clone https://gitlab.com/sealy/simple-todo-app.git
cd simple-todo-app

git checkout backend-connection

npm install
npm run build

cd ../../

cd backend
git clone https://gitlab.com/sealy/simple-todo-backend.git

cd ..
docker compose up

elif [[ $1 -eq 5 ]]; then
# TODO: ./todo.sh 5
    docker stop $(docker ps -aq);
    images=("website-image" "devops-primer" "nginx")
    for image in "${images[@]}"; do
        docker rmi $(docker images -q "$image")
    done
fi
