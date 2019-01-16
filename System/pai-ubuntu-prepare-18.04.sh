#!/bin/bash
# pai-ubuntu-prepare.sh
# Install new instance Inc. docker
# pai-script-id=9729e1ee-60d7-42cb-8f01-dcf075b4cbf9
# Created by Eran Caballero on Wed May 30 10:20:08 UTC 2018
# Generated by PAI Linux Bot
# Copyrights PAI Tech INC 2018, all rights reserved

# PAI includes

PAI=/var/PAI
PAI_LOGS=$PAI/Logs
PAI_PROFILE_FILE=/etc/profile

PAI_STARTUP_SCRIPT_FILE=pai-startup.sh
PAI_STARTUP_FOLDER=/var/PAI/Startup
PAI_STARTUP_SCRIPT_FILE_PATH=$PAI_STARTUP_FOLDER/$PAI_STARTUP_SCRIPT_FILE
INIT_FOLDER=/etc/init.d
PAI_STARTUP_SCRIPT_FILE_LINK=pai-startup
PAI_INSTALLER_NAME="Pai Startup"

. ./pai.sh

PAI_INSTALLER_NAME="Pai Prepare Linux Ubuntu"

# PAI functions

pai_9729e1ee-60d7-42cb-8f01-dcf075b4cbf9_intro()
{
	pai_log "Prepairing Linux OS For Pai"
}

pai_write_to_script()
{
	echo -e $1>>$PAI_STARTUP_SCRIPT_FILE_PATH
}

pai_update_os()
{
	pai_log "Updating OS & Installing Default (Linux)..."
	PAI_REQUIERED_PREPARE_INSTALLATION="pydf zip unzip htop git build-essential libssl-dev libffi-dev software-properties-common python-dev python-numpy python-tk python3-dev python3-tk python3-numpy"
	apt-get -qq update
	apt-get -qq install $PAI_REQUIERED_PREPARE_INSTALLATION
	#apt-get -qq -y upgrade
	pai_log "OS updated :)"
}

pai_update_locale()
{
	locale-gen "en_US.UTF-8"
	#dpkg-reconfigure locales #IBM
	update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 #MS
	timedatectl set-timezone Etc/UTC
	pai_log "Locale (UTF+TZ) updated"
}

pai_handle_sudoers()
{
	pai_log "Handling Sudoers"
	dpkg-statoverride --update --add root sudo 4750 /bin/su
}

pai_update_profiles()
{
	if grep -r "# PAI :]" $PAI_PROFILE_FILE;
	then
		pai_log "Profile file already updated"
	else
		echo "# PAI :]" >> $PAI_PROFILE_FILE
		echo "PAI=/var/PAI" >> $PAI_PROFILE_FILE
		echo "" >> $PAI_PROFILE_FILE
		echo "LD_LIBRARY_PATH=/usr/local/lib/" >> $PAI_PROFILE_FILE
		echo "PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/" >> $PAI_PROFILE_FILE
		echo "" >> $PAI_PROFILE_FILE
		echo "JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> $PAI_PROFILE_FILE
		echo "JRE_HOME=/usr/lib/jvm/java-8-oracle/jre/bin/java" >> $PAI_PROFILE_FILE
		echo "PATH=$PATH:$HOME/bin:JAVA_HOME:JRE_HOME:$PAI/System" >> $PAI_PROFILE_FILE
		. $PAI_PROFILE_FILE
		echo "nameserver 8.8.8.8" >> /etc/resolv.conf
		pai_log "Profile file updated"
	fi
}

pai_ssh_setup()
{
	SSHD_CONFIG_FILE="/etc/ssh/sshd_config"
	pai_log "Reconfigure password authentication"
	sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' $SSHD_CONFIG_FILE
	service ssh restart
	pai_log "Done..."
}

pai_add_all_ppas()
{
	PAI_JAVA_PPA=webupd8team/java
	pai_add_ppa $PAI_JAVA_PPA
	pai_log_sep
}

pai_java_install()
{
	pai_log "Accept the Oracle license.."
        echo debconf shared/accepted-oracle-license-v1-1 select true | \
        debconf-set-selections && echo debconf shared/accepted-oracle-license-v1-1 seen true | \
        debconf-set-selections
	#Installing JAVA
	pai_log "Installing Java..."
	apt-get -qq -y install oracle-java8-installer && \
	update-java-alternatives -s java-8-oracle
	pai_log_sep
}

pai_nodejs_pm2_install()
{
        # Installing Nodejs
        curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - && \
        apt-get install -qq -y nodejs
        npm i -g npm
        #Install PM2
        npm i -g pm2 -g && pm2 startup
}

pai_create_startup_file()
{

	# checking if startup folder exists

	pai_validate_folder $PAI_STARTUP_FOLDER

	if [ -f $PAI_STARTUP_SCRIPT_FILE ]; then
		touch $PAI_STARTUP_SCRIPT_FILE_PATH
	else
		cp $PAI/System/pai-startup-empty.sh $PAI_STARTUP_SCRIPT_FILE_PATH
	fi

	pai_write_to_script ""
	pai_write_to_script ""
	pai_write_to_script '$SCRIPT_NAME_SH'

	chmod +x $PAI_STARTUP_SCRIPT_FILE_PATH

	if [ -f $PAI_STARTUP_SCRIPT_FILE_LINK ]; then
		pai_log "removing startup definitions"
		rm $PAI_STARTUP_SCRIPT_FILE_LINK
		update-rc.d -f $PAI_STARTUP_SCRIPT_FILE_LINK remove
	fi

	ln -s $PAI_STARTUP_SCRIPT_FILE_PATH $INIT_FOLDER/$PAI_STARTUP_SCRIPT_FILE_LINK
	update-rc.d $PAI_STARTUP_SCRIPT_FILE_LINK
}

pai_folders_validate()
{
	pai_validate_folder $PAI
	pai_validate_folder $PAI_MEDIA_FOLDER
	pai_validate_folder $PAI_MEDIA_PUBLIC_FOLDER
	pai_validate_folder $PAI_LOGS

	chmod -R 777 $PAI_LOGS
}

pai_9729e1ee-60d7-42cb-8f01-dcf075b4cbf9_end()
{
	pai_log_sep
	pai_log "Done..."
}



# PAI MAIN FLOW

#pai_folders_validate
pai_prepare_intro
#pai_update_os
#pai_update_locale
#pai_handle_sudoers
#pai_update_profiles
#pai_ssh_setup
#pai_add_all_ppas
#pai_java_install
#pai_nodejs_pm2_install
pai_create_startup_file
pai_9729e1ee-60d7-42cb-8f01-dcf075b4cbf9_end
