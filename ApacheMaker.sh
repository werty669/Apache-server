#!/bin/sh
apt update
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:team-xbmc/ppa
apt update 
sudo apt-get install kodi
apt upgrade
apt install apache2
apt install git
echo apache-version
#read -p "click enter to continue on to the next step"
apt-get install ufw
ufw allow 'Apache'
systemctl restart apache2 &
systemctl status apache2 &
sudo mkdir -p /var/www/caden.local/html
sudo chown -R $USER:$USER /var/www/caden.local/html
sudo chmod -R 755 /var/www/caden.local
cd /var/www/caden.local/html
git init 
git remote add origin https://github.com/werty669/Apache-server.git
git pull origin master
touch ./sync.sh
echo "#!/bin/bash
      git pull origin master
      exit" >> sync.sh
chmod 755 sync.sh
touch /etc/apache2/sites-available/caden.local.conf
echo "<VirtualHost *:80>
	ServerAdmin admin@sampledomain.com
	ServerName sampledomain.com
	ServerAlias www.sampledomain.com
	DocumentRoot /var/www/caden.local/html
	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" >> /etc/apache2/sites-available/caden.local.conf
sudo a2ensite caden.local.conf
sudo a2dissite 000-default.conf
sudo systemctl restart apache2
sudo apache2ctl configtest
watch -n 5 ./sync.sh
exit
