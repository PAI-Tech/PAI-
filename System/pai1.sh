
#!/bin/bash

#	Created by Eran Caballero on 03/05/2018.
#	Copyrights PAI Tech 2018, all rights reserved


PAI=/var/PAI
PAI_SYSTEM_FOLDER=$PAI/System


echo "Hi there..."

type wget >/dev/null 2>&1 || { echo >&2 "I require wget but it's not installed.  Aborting."; exit 1; }
