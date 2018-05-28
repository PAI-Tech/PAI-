
#!/bin/bash

#	
#	PAI Logger
#	Write to log file.
# Created by Eran Caballero on 03/05/2018.  
# Copyrights PAI Tech 2018, all rights reserved 


PAI_OS_LOG_FILE=$PAI/Logs/pai.log

pai_file_log()
{
	
	NOW=$(date)
	echo " | $1" >>$PAI_OS_LOG_FILE
}


pai_log_console()
{
	echo "  PAI: $1"
}

pai_log()
{
	NOW=$(date +%F-%T)
	pai_log_console "[$NOW] $1"
	pai_file_log "[$NOW] $1"
}

pai_log_sep()
{

	_SEP="+----------------------------------------------------------------------"
	echo ""
	echo $_SEP
	echo ""
}
