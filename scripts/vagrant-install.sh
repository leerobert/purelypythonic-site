#! /bin/bash

sudo apt-get update
sudo apt-get upgrade

##########################
## GENERAL UBUNTU SETUP ##
##########################

# good login protection
sudo apt-get install -y fail2ban

# set up the deploy user
useradd deploy
mkdir /home/deploy
mkdir /home/deploy/.ssh
chmod 700 /home/deploy/.ssh
cp ~/.ssh/authorized_keys /home/deploy/.ssh/
chmod 400 /home/deploy/.ssh/authorized_keys
chown deploy:deploy /home/deploy -R

# passwd deploy to something good

echo "deploy ALL=(ALL) ALL" >> /etc/sudoers

# Modified ssh for no root login and no password authentication
echo "PermitRootLogin no" >> /etc/ssh/sshd_config
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
service ssh restart

cp /root/.bashrc /home/deploy/ && cp /root/.profile /home/deploy/
chown deploy:deploy /home/deploy -R

##################
## DJANGO SETUP ##
##################
sudo su - deploy

sudo apt-get update
sudo apt-get -y install git libpq-dev python-dev python-virtualenv redis-server rabbitmq-server libjpeg-turbo-progs
sudo apt-get -y install libjpeg-dev libfreetype6 libfreetype6-dev zlib1g-dev

# switch to deploy and build folders
su - deploy
mkdir ~/logs

# move files from vagrant folder to here
mkdir site && cp -r /vagrant/src site && cp /vagrant/requirements.txt site
cd site
virtualenv -p python3 .
source bin/activate
pip install -r requirements.txt
pip install gunicorn

cp /vagrant/scripts/files/gunicorn_start bin
chmod +x bin/gunicorn_start

########################
## SUPERVISOR SETUP  ###
########################
sudo apt-get -y install supervisor
cp /vagrant/scripts/files/deploy.conf /etc/supervisor/conf.d/deploy.conf
sudo supervisorctl reread
sudo supervisorctl update
touch /home/deploy/logs/gunicorn_supervisor.log
chown deploy:deploy /home/deploy/logs/gunicorn_supervisor.log


#########################
## NGINX SETUP/INSTALL ##
#########################
sudo apt-get -y install nginx
sudo service nginx start
cp /vagrant/scripts/files/deploy /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/deploy /etc/nginx/sites-enabled/deploy
sudo service nginx restart

################
## PRODUCTION ##
################

echo "PRODUCTION=true" >> /etc/environment 
# echo the gmail password environment as well
# echo "GMAIL_PASSWORD=passwordhere" >> /etc/environment
