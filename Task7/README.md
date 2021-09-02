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
```

Add several user groups

![image](https://user-images.githubusercontent.com/88404376/131835226-243ae63d-f30e-4f0c-9add-0270ea81e9b1.png)

Create Dashboard 

![image](https://user-images.githubusercontent.com/88404376/131839790-6631f1ab-f015-48e2-8971-1b8e87c2475b.png)

1.4 Active check vs passive check - use both types.

```
Go to: Configuration → Hosts
Find added active and passive items in 'Items' 
See trapper and poller 
```
![image](https://user-images.githubusercontent.com/88404376/131841538-c8829f67-6c58-4c6b-bb00-27c31144dfb3.png)

1.5 Make an agentless check of any resource (ICMP ping)

```
Ssh to Zabbix server and edit /etc/zabbix/zabbix_server.conf file
Type StartPingers=10 FpingLocation=/usr/sbin/fping. at the end of the file
Go to Zabbix UI 
Go to Configuration -> Hosts -> Create host
Fill hostname, groups, link new templates (e.g. Template Module ICMP Ping) 
Go to Monitoring -> Hosts -> latest data 
Press the resource name 
Press ping
```
![image](https://user-images.githubusercontent.com/88404376/131848204-c4951bbd-0ee0-4b54-a75a-4335a3b47959.png)

1.6 Provoke an alert - and create a Maintenance instruction

```
Go to Configuration -> Hosts
Create a trigger for any host 
Press create trigger
Create trigger for CPU Idle Time
```
![image](https://user-images.githubusercontent.com/88404376/131843125-ae337a89-3e7a-45a0-ad3a-c3b17c6344d1.png)

![image](https://user-images.githubusercontent.com/88404376/131843057-4e26ba9d-8955-4041-b7e8-03bd093d294d.png)

![image](https://user-images.githubusercontent.com/88404376/131843224-4fdaf82a-3172-4476-815e-3b85dd4d62e3.png)

![image](https://user-images.githubusercontent.com/88404376/131843273-75479502-33e3-4650-8e3c-a37a3dc23283.png)

## ELK

2.1 Install and configure ELK
2.2 Organize collection of logs from docker to ELK and receive data from running containers
2.3 Customize your dashboards in ELK
```
Run ELK with docker-compose (see the compose file in repo)
Add the filebeat.yml for Kibana to recieve docker logs
Run docker-compose up
Go to http://(IP):5601.
Configure the ElasticSearch displayed in Kibana
```
![image](https://user-images.githubusercontent.com/88404376/131843974-857c9299-50ba-46aa-a7ba-d4265e3e2ec6.png)

![image](https://user-images.githubusercontent.com/88404376/131844038-beb16e8f-727c-45ef-8277-7015e9177f04.png)

```
Visualize the logs in the Kibana interface.
```

![image](https://user-images.githubusercontent.com/88404376/131848967-0b27feac-9a61-43e6-8f19-339dcafd1585.png)

2.5 Configure monitoring in ELK, get metrics from your running containers

```
 Go to Home -> add metric data -> docker metrics
 Configure Metricbeat
 See the result
```
![image](https://user-images.githubusercontent.com/88404376/131849182-786ddb17-a1bb-4450-8048-93f464500660.png)

See the dashboard

![image](https://user-images.githubusercontent.com/88404376/131849288-be5adeb3-edeb-48dc-95c4-1b832b09c62e.png)

Custom dashboard

![image](https://user-images.githubusercontent.com/88404376/131849413-802d8bc1-6f50-42c4-a4d1-2fef9df02116.png)

## Grafana

Go to http://(IP):3000 
Log in to grafana (admin,admin)
Go to Configuration -> Data Sources -> Add data source
Change configuration
Press 'Save and Test'

![image](https://user-images.githubusercontent.com/88404376/131849779-c49e095b-090b-43b8-87fb-72f4f59f7582.png)

![image](https://user-images.githubusercontent.com/88404376/131849866-c8b72c64-fd03-4ec5-84a1-e4c49e5198a7.png)

Preview dashboard

![image](https://user-images.githubusercontent.com/88404376/131850145-4629378b-d214-445b-9cd7-79527f40f178.png)

