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
echo "*****************MAIN MENU*****************"
echo "*********http://www.innovacoin.io/**********"
echo "*******************************************"

echo -e "Installing SWAP file"
echo -e "--------------------------------------------------------------------------------------------------------------------------"
#Asking for SWAP
echo -e "${YELLOW}Would you like to install 2GB SWAP memory file (no if you did it before, yes if you are installing your first node)? [y/n]${NC}"
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
echo -e "${YELLOW}Would you like to Enable firewall and open port 14520 (no if you did it before, yes if you are installing your first node)? [y/n]${NC}"
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

echo -e "Installing Dependencies"
echo -e "--------------------------------------------------------------------------------------------------------------------------"
#Asking for permission
echo -e "${YELLOW}Do you want to install all needed dependencies (no if you did it before, yes if you are installing your first node)? [y/n]${NC}"
read DOSETUP
# echo ${DOSETUP}
if [[ ${DOSETUP,,} =~ "y" ]] ; then
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
	
	echo -e "Dependencies Installed, Now Downloading wallet"
	echo -e "--------------------------------------------------------------------------------------------------------------------------"

	
	
	
fi

#Checking OS version
if [[ $(lsb_release -d) == *16.04* ]]; then
	echo -e "Version Found Ubuntu 16.04"
	cd ~
	sudo apt-get install unzip -y
	mkdir .innovacore
	mkdir inncoin
	cd inncoin
	wget https://www.dropbox.com/s/1b56ioxqcc1mpwi/Innova-Ubuntu-16.04.zip
	sudo unzip Innova-Ubuntu-16.04.zip
	sudo cp innovad /usr/local/bin
	sudo cp innova-cli /usr/local/bin
	sudo chmod +x /usr/local/bin/innovad
	sudo chmod +x /usr/local/bin/innova-cli
	sudo apt-get install -y pwgen
	GEN_PASS=`pwgen -1 20 -n`
	echo -e "rpcuser=innovauser\nrpcpassword=${GEN_PASS}\nrpcport=14519\nport=14520\nlisten=1\nmaxconnections=256\ndaemon=1\nserver=1" > /root/.innovacore/innova.conf
	echo -e "addnode=209.250.240.159:14520\naddnode=207.148.30.107:14520\naddnode=195.154.150.149:14520\naddnode=62.210.251.30:14520\naddnode=66.206.29.179:14520\naddnode=62.210.245.190:14520" >> /root/.innovacore/innova.conf
	echo -e "Wallet Downloaded. Setting up your Node"
	sudo innovad -daemon
	echo "PLEASE WAIT"
	sleep 20
	masternodekey=$(innova-cli masternode genkey)
	echo -e "masternode=1\nmasternodeprivkey=$masternodekey" >> /root/.innovacore/innova.conf
	echo "PLEASE WAIT"
	sleep 20
	echo "Loading bootstrap"
	wget https://raw.githubusercontent.com/mangae/Innova_bootstrap/master/bootstrap.sh
	bash bootstrap.sh
	cd
	echo "Please record your Masternode private key and use it for setup at your local wallet side: $masternodekey"
	echo "Thank you and welcome to INNOVA world"
elif [[ $(lsb_release -d) == *18.04* ]]; then
	echo -e "Version Found Ubuntu 18.04"
	cd ~
	sudo apt-get install unzip -y
	mkdir .innovacore
	mkdir inncoin
	cd inncoin
	wget https://www.dropbox.com/s/1b56ioxqcc1mpwi/Innova-Ubuntu-16.04.zip
	sudo unzip Innova-Ubuntu-16.04.zip
	sudo cp innovad /usr/local/bin
	sudo cp innova-cli /usr/local/bin
	sudo chmod +x /usr/local/bin/innovad
	sudo chmod +x /usr/local/bin/innova-cli
	sudo apt-get install -y pwgen
	GEN_PASS=`pwgen -1 20 -n`
	echo -e "rpcuser=innovauser\nrpcpassword=${GEN_PASS}\nrpcport=14519\nport=14520\nlisten=1\nmaxconnections=256\ndaemon=1\nserver=1" > /root/.innovacore/innova.conf
	echo -e "addnode=209.250.240.159:14520\naddnode=207.148.30.107:14520\naddnode=195.154.150.149:14520\naddnode=62.210.251.30:14520\naddnode=66.206.29.179:14520\naddnode=62.210.245.190:14520" >> /root/.innovacore/innova.conf
	echo -e "Wallet Downloaded. Setting up your Node"
	sudo innovad -daemon
	echo "PLEASE WAIT"
	sleep 20
	masternodekey=$(innova-cli masternode genkey)
	echo -e "masternode=1\nmasternodeprivkey=$masternodekey" >> /root/.innovacore/innova.conf
	echo "PLEASE WAIT"
	sleep 20
	echo "Loading bootstrap"
	wget https://raw.githubusercontent.com/mangae/Innova_bootstrap/master/bootstrap.sh
	bash bootstrap.sh
	cd
	echo "Please record your Masternode private key and use it for setup at your local wallet side: $masternodekey"
	echo "Thank you and welcome to INNOVA world"
elif [[ $(lsb_release -d) == *18.10* ]]; then
	echo -e "Version Found Ubuntu 18.10"
	cd ~
	sudo apt-get install unzip -y
	mkdir .innovacore
	mkdir inncoin
	cd inncoin
	wget https://www.dropbox.com/s/1b56ioxqcc1mpwi/Innova-Ubuntu-16.04.zip
	sudo unzip Innova-Ubuntu-16.04.zip
	sudo cp innovad /usr/local/bin
	sudo cp innova-cli /usr/local/bin
	sudo chmod +x /usr/local/bin/innovad
	sudo chmod +x /usr/local/bin/innova-cli
	sudo apt-get install -y pwgen
	GEN_PASS=`pwgen -1 20 -n`
	echo -e "rpcuser=innovauser\nrpcpassword=${GEN_PASS}\nrpcport=14519\nport=14520\nlisten=1\nmaxconnections=256\ndaemon=1\nserver=1" > /root/.innovacore/innova.conf
	echo -e "addnode=209.250.240.159:14520\naddnode=207.148.30.107:14520\naddnode=195.154.150.149:14520\naddnode=62.210.251.30:14520\naddnode=66.206.29.179:14520\naddnode=62.210.245.190:14520" >> /root/.innovacore/innova.conf
	echo -e "Wallet Downloaded. Setting up your Node"
	sudo innovad -daemon
	echo "PLEASE WAIT"
	sleep 20
	masternodekey=$(innova-cli masternode genkey)
	echo -e "masternode=1\nmasternodeprivkey=$masternodekey" >> /root/.innovacore/innova.conf
	echo "PLEASE WAIT"
	sleep 20
	echo "Loading bootstrap"
	wget https://raw.githubusercontent.com/mangae/Innova_bootstrap/master/bootstrap.sh
	bash bootstrap.sh
	cd
	echo "Please record your Masternode private key and use it for setup at your local wallet side: $masternodekey"
	echo "Thank you and welcome to INNOVA world"
fi

exit 0

