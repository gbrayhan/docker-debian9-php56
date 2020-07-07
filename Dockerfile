FROM debian:stretch
# docker image gbrayhan/debian9_php56:v1.1
MAINTAINER Alejandro Guerrero (gbrayhan@gmail.com)

RUN apt-get update && apt-get upgrade -y --no-install-recommends ; \
apt-get install -y gnupg2 -y ; \
apt install ca-certificates apt-transport-https wget unzip zip curl -y ; \
wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - ; \
echo "deb https://packages.sury.org/php/ stretch main" | tee /etc/apt/sources.list.d/php.list ;  \
apt update -y && apt install php5.6 -y && apt install -y php5.6-cli php5.6-common php5.6-curl php5.6-zip php5.6-mbstring php5.6-mysql php5.6-xml php5.6-soap php5.6-gd php5.6-bcmath php5.6-amqp php5.6-mongodb ; \
mkdir /srv/app && chmod 755 /srv -R  ; \
echo "<VirtualHost *:80> \n  ServerName localhost \n  ServerAdmin admin@app.com \n  DocumentRoot /srv/app \n  \n  ErrorLog /var/log/apache2/app-error.log \n  CustomLog /var/log/apache2/app-access.log combined \n  \n  <Directory /srv/app/> \n    Options -Indexes +FollowSymLinks +MultiViews \n    AllowOverride All \n    Require all granted \n  </Directory> \n  \n</VirtualHost> " > /etc/apache2/sites-available/000-default.conf ; \
a2enmod rewrite && \
LINE='ServerName localhost' ;\
FILE='/etc/apache2/apache2.conf' ; \
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE" ;
