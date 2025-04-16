#!/bin/bash
sudo yum update -y
sudo yum install -y nginx
echo "image" | sudo tee /usr/share/nginx/html/image.html
sudo service nginx start
