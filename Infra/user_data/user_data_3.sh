  #!/bin/bash
  sudo yum update -y
  sudo yum install -y nginx
  echo "register" | sudo tee /usr/share/nginx/html/register.html
  sudo service nginx start
