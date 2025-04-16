#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras enable nginx1
sudo yum install -y nginx
              
sudo mkdir -p /usr/share/nginx/html/register

echo '<html>
<head><title>Register</title></head>
<body>
<h1>Register page</h1>
</body>
</html>' | sudo tee /usr/share/nginx/html/register/index.html > /dev/null

# Configure Nginx for /register
sudo tee /etc/nginx/conf.d/register.conf > /dev/null <<EOT
server {
  listen 80;
  location /register {
    root /usr/share/nginx/html;
    index index.html;
  }
}
EOT
sudo systemctl restart nginx
sudo systemctl enable nginx
