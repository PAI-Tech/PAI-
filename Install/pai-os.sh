
#!/bin/bash

#
#	PAI-OS functions
#	PAI-OS basics.
# Created by Eran Caballero on 03/05/2018.
# Copyrights PAI Tech 2018, all rights reserved

PAI=/var/PAI
PAI_SYSTEM_FOLDER=$PAI/System



pai_run_system_script()
{
	sh $PAI_SYSTEM_FOLDER/$1
}


pai_validate_folder() #Ubuntu
{
	if ! [ -d $1 ]; then
		mkdir -p $1
	fi
}

pai_validate_if_then_else()
{
  if [ -f $PAI_STARTUP_SCRIPT_FILE ]; then
                touch $PAI_STARTUP_SCRIPT_FILE_PATH
        else
                cp $PAI/System/pai-startup-empty.sh $PAI_STARTUP_SCRIPT_FILE_PATH
        fi
}

pai_validate_folder_mv()
{
        if ! [ -d $1 ]; then
                mv ../$1 $PAI
        fi
}

pai_validate_folder_rm()
{
        if ! [ -f $1 ]; then
                rm -rf $1
        fi
}

pai_add_ppa() 
{
  for i in "$@"; do
    grep -h "^deb.*$i" /etc/apt/sources.list.d/* > /dev/null 2>&1
    if [ $? -ne 0 ]
    then
      echo "Adding ppa:$i"
      add-apt-repository -y ppa:$i
      apt-get -qq update
    else
      echo "ppa:$i already exists"
    fi
  done
}
