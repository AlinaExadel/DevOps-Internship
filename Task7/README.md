## Zabbix

- 1.1 Install on server, configure web and base
```
sudo apt update && sudo apt upgrade
wget https://repo.zabbix.com/zabbix/5.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.0-1+focal_all.deb
dpkg -i zabbix-release_5.0-1+focal_all.deb
sudo apt update && sudo apt upgrade
sudo apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent mysql-server

sudo mysql_secure_installation
sudo mysql -u root -p
create database zabbix character set utf8 collate utf8_bin;
create user zabbix@localhost identified by 'password';
grant all privileges on zabbix.* to zabbix@localhost;
privileges;

sudo zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -u zabbix -p zabbix
sudo mysql -u root -p

sudo nano /etc/zabbix/zabbix_server.conf
Uncomment DBPassword and type 'password' 

sudo nano /etc/zabbix/apache.conf
Update the timezone 'Etc/GMT-4'
```
- 1.2 Prepare VM or instances. 
- 1.3 Make several of your own dashboards, where to output data from your triggers (you can manually trigger it)

```

sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2

Launch Zabbix - http://18.222.26.235:5601
Check timezone, the name of the database and user, provide the password
Use Credentials: username - Admin, password - password

Add several user groups

![Alt text](https://user-images.githubusercontent.com/88404376/129983846-c5bea4f7-8797-487c-8ae7-819d91552fbd.PNG?raw=true "Title")


```
