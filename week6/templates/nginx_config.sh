#!/bin/bash

# Install nginx
sudo apt update
sudo apt install -y nginx

cd /usr/share/nginx/html
sudo apt install -y git
sudo git clone https://gitlab.com/rzlthms11/simple-static-web-app.git

sudo mv simple-static-web-app/* .
sudo rm -rf simple-static-web-app
sudo cp /usr/share/nginx/html/index.html /var/www/html/index.nginx-debian.html
sudo systemctl enable --now nginx

