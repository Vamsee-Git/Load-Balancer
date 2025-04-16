#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras enable nginx1
sudo yum install -y nginx
echo '<html>
<head><title>Home</title></head>
body>
<h1>Home page</h1>
</body>
</html>' | sudo tee /usr/share/nginx/html/index.html > /dev/null

sudo systemctl restart nginx
sudo systemctl enable nginx
