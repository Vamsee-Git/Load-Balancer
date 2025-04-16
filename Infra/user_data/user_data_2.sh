#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras enable nginx1
sudo yum install -y nginx
              
sudo mkdir -p /usr/share/nginx/html/images

echo '<html>
<head><title>Images</title></head>
<body>
<h1>Image page </h1>
</body>
</html>' | sudo tee /usr/share/nginx/html/images/index.html > /dev/null

# Configure Nginx for /images
sudo tee /etc/nginx/conf.d/images.conf > /dev/null <<EOT
server {
  listen 80;
  location /images {
      root /usr/share/nginx/html;
      index index.html;
  }
}
EOT
