#!/bin/bash
sudo apt -y update
sudo apt -y install apache2
OS_VERSION=$(cat /proc/version)
cat <<EOF > /var/www/html/index.html
<html>
 <head>
 <title>Hello Wordl</title>
 </head>
 <body>
 <h3>Hello World</h3>
 <p>$OS_VERSION</p>
 </body>
</html>
EOF
sudo systemctl start apache2
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerdio
