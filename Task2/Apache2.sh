#!/bin/bash
apt -y update
apt -y install apache2
OS_VERSION=$(cat/proc/version)
echo "<html>
    <head>
        <title>Example</title>
    </head>
    <body>
        <p>$OS_VERSION</p>
    </body>
</html>"  > /var/www/html/index.html
sudo systemctl start apache2
