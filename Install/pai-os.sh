
#!/bin/bash

#	

PAI=/var/PAI
PAI_SYSTEM_FOLDER=$PAI/System

# to-do -> export $PAI as global variable



pai_run_system_script()
{
	sh ./$1
}


pai_validate_folder()
{
	if ! [ -d $1 ]; then
		mkdir -p $1
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
