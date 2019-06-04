#!/bin/bash
##
##
##
RED='\033[1;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
YELLOW='\033[1;33m'
BROWN='\033[0;34m'
NC='\033[0m' # No Color

echo && echo
echo "*******************v1.12.1******************"
echo "*****************InnovaCoin***************"
echo "*****************Linux 16.04 wallet update*****************"
echo "*********http://www.innovacoin.io/**********"
echo "*******************************************"

echo -e "Installing SWAP file"
echo -e "--------------------------------------------------------------------------------------------------------------------------"
#Asking for SWAP
echo -e "${YELLOW}Would you like to install 2GB SWAP memory file (no if you did it before, yes if you have no Swap file already set)? [y/n]${NC}"
read SWAPSETUP
# echo ${SWAPSETUP}
if [[ ${SWAPSETUP,,} =~ "y" ]] ; then
	sudo fallocate -l 2G /swapfile
	sudo chmod 600 /swapfile
	sudo mkswap /swapfile
	sudo swapon /swapfile
	echo -e "/swapfile none swap sw 0 0" >> /etc/fstab
	echo -e "Swap file created, Now Installing Dependencies"
	echo -e "--------------------------------------------------------------------------------------------------------------------------"

fi

#Asking for Firewall
echo -e "${YELLOW}Would you like to Enable firewall and open port 14520 (no if you did it before, yes if you need to open port 14520)? [y/n]${NC}"
read FWSETUP
# echo ${FWSETUP}
if [[ ${FWSETUP,,} =~ "y" ]] ; then
	sudo apt-get install -y ufw
	sudo ufw allow ssh
	sudo ufw limit ssh/tcp
	sudo ufw allow 14520/tcp
	sudo ufw default allow outgoing
	echo "y" | sudo ufw enable
	echo -e "Firewall rules applied, Now Installing Dependencies"
	echo -e "--------------------------------------------------------------------------------------------------------------------------"

fi

	echo "${YELLOW}Installing dependencies"
	sleep 5
	sudo apt-get update
	sudo apt-get -y upgrade
	sudo apt-get -y dist-upgrade
	sudo apt-get -y install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils
	sudo apt-get -y install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
	sudo apt-get -y install libboost-all-dev
	sudo add-apt-repository  -y  ppa:bitcoin/bitcoin
	sudo apt-get update
	sudo apt-get install -y libdb4.8-dev libdb4.8++-dev
	apt-get install -y libminiupnpc-dev libzmq3-dev libevent-pthreads-2.0.5
	
	sudo sh -c 'echo "/usr/local/lib" >> /etc/ld.so.conf.d/local.conf'
	sudo ldconfig
	sudo apt-get install -y qt5-default
	
	sleep 5
	echo -e "Dependencies Installed, Now Updating your wallet"
	echo -e "--------------------------------------------------------------------------------------------------------------------------"



#Checking OS version
if [[ $(lsb_release -d) == *16.04* ]]; then
	echo -e "Version Found Ubuntu 16.04"
	cd ~
	echo "Stopping Innova Daemon"
	sudo innova-cli stop
	sleep 10
	sudo killall -9 innovad
	sudo apt-get install unzip -y
	mkdir inncoin
	cd inncoin
	wget https://www.dropbox.com/s/1b56ioxqcc1mpwi/Innova-Ubuntu-16.04.zip
	sudo unzip Innova-Ubuntu-16.04.zip
	sudo rm /usr/local/bin/innovad
	sudo rm /usr/local/bin/innova-cli
	sudo cp innovad /usr/local/bin
	sudo cp innova-cli /usr/local/bin
	sudo chmod +x /usr/local/bin/innovad
	sudo chmod +x /usr/local/bin/innova-cli
	echo -e "addnode=209.250.240.159:14520\naddnode=207.148.30.107:14520\naddnode=195.154.150.149:14520\naddnode=62.210.251.30:14520\naddnode=66.206.29.179:14520\naddnode=62.210.245.190:14520" >> /root/.innovacore/innova.conf
	echo -e "Wallet Downloaded. Setting up your Node"
	sudo innovad -deamon
	echo "PLEASE WAIT"
	sleep 20
	echo "Loading bootstrap"
	wget https://raw.githubusercontent.com/mangae/Innova_bootstrap/master/bootstrap.sh
	bash bootstrap.sh
	cd
	echo "Please check if your wallet is receiving connections and synchronizing blocks before starting your masternode"
	echo "Thank you and welcome to INNOVA world"
elif [[ $(lsb_release -d) == *18.04* ]]; then
	echo -e "Version Found Ubuntu 18.04"
	cd ~
	echo "Stopping Innova Daemon"
	sudo innova-cli stop
	sleep 10
	sudo killall -9 innovad
	sudo apt-get install unzip -y
	mkdir inncoin
	cd inncoin
	wget https://www.dropbox.com/s/1b56ioxqcc1mpwi/Innova-Ubuntu-16.04.zip
	sudo unzip Innova-Ubuntu-16.04.zip
	sudo rm /usr/local/bin/innovad
	sudo rm /usr/local/bin/innova-cli
	sudo cp innovad /usr/local/bin
	sudo cp innova-cli /usr/local/bin
	sudo chmod +x /usr/local/bin/innovad
	sudo chmod +x /usr/local/bin/innova-cli
	echo -e "addnode=209.250.240.159:14520\naddnode=207.148.30.107:14520\naddnode=195.154.150.149:14520\naddnode=62.210.251.30:14520\naddnode=66.206.29.179:14520\naddnode=62.210.245.190:14520" >> /root/.innovacore/innova.conf
	echo -e "Wallet Downloaded. Setting up your Node"
	sudo innovad -deamon
	echo "PLEASE WAIT"
	sleep 20
	echo "Loading bootstrap"
	wget https://raw.githubusercontent.com/mangae/Innova_bootstrap/master/bootstrap.sh
	bash bootstrap.sh
	cd
	echo "Please check if your wallet is receiving connections and synchronizing blocks before starting your masternode"
	echo "Thank you and welcome to INNOVA world"
elif [[ $(lsb_release -d) == *18.10* ]]; then
	echo -e "Version Found Ubuntu 18.10"
	cd ~
	echo "Stopping Innova Daemon"
	sudo innova-cli stop
	sleep 10
	sudo killall -9 innovad
	sudo apt-get install unzip -y
	mkdir inncoin
	cd inncoin
	wget https://www.dropbox.com/s/1b56ioxqcc1mpwi/Innova-Ubuntu-16.04.zip
	sudo unzip Innova-Ubuntu-16.04.zip
	sudo rm /usr/local/bin/innovad
	sudo rm /usr/local/bin/innova-cli
	sudo cp innovad /usr/local/bin
	sudo cp innova-cli /usr/local/bin
	sudo chmod +x /usr/local/bin/innovad
	sudo chmod +x /usr/local/bin/innova-cli
	echo -e "addnode=209.250.240.159:14520\naddnode=207.148.30.107:14520\naddnode=195.154.150.149:14520\naddnode=62.210.251.30:14520\naddnode=66.206.29.179:14520\naddnode=62.210.245.190:14520" >> /root/.innovacore/innova.conf
	echo -e "Wallet Downloaded. Setting up your Node"
	sudo innovad -deamon
	echo "PLEASE WAIT"
	sleep 20
	echo "Loading bootstrap"
	wget https://raw.githubusercontent.com/mangae/Innova_bootstrap/master/bootstrap.sh
	bash bootstrap.sh
	cd
	echo "Please check if your wallet is receiving connections and synchronizing blocks before starting your masternode"
	echo "Thank you and welcome to INNOVA world"
fi

exit 0

