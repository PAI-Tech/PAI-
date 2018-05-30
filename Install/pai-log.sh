
#!/bin/bash

#	


PAI_OS_LOG_FILE=$PAI/Logs/misi.log

pai_file_log()
{
	
	NOW=$(date)
	echo " | $1" >>$PAI_OS_LOG_FILE
}


pai_log_console()
{
	echo "  Pai: $1"
}

pai_log()
{
	NOW=$(date +%F-%T)
	pai_log_console "[$NOW] $1"
	pai_file_log "[$NOW] $1"
}

pai_log_sep()
{

	PAI_SEP="+----------------------------------------------------------------------"
	echo ""
	echo $PAI_SEP
	echo ""
}

