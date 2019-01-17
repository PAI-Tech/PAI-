#!/bin/bash

# pai-install
# PAI OS for Linux
# pai-script-id=3C1F2ED5-C28A-40EF-833E-9D93B8502C6E
# Created by Tamir Fridman on Mon May 28 18:01:48 IDT 2018
# Generated by PAI Linux Bot
# Copyrights PAI Tech INC 2018, all rights reserved


# PAI includes

PAI=/var/PAI
PAI_BACKUP_FOLDER=$PAI/Backup
PAI_BACKUP_MYSQL_FOLDER=$PAI_BACKUP_FOLDER/MySQL
PAI_BOT_FOLDER=$PAI/Bot
PAI_BOT_TEST_FILE=$PAI_BOT_FOLDER/test.sh
PAI_BOT_CONFIG_FILE=$PAI_BOT_FOLDER/$PAI_NET_ID/settings/strings.cfg
PAI_CONFIG_FOLDER=$PAI/Config
PAI_CONFIG_FILE=$PAI_CONFIG_FOLDER/pai.config
PAI_LOGS_FOLDER=$PAI/Logs
PAI_SYSTEM_FOLDER=$PAI/System
PAI_STARTUP_FOLDER=$PAI/Startup
PAI_CODE_FOLDER=$PAI/PAI-CODE/
PAI_CODE_MODULES_FOLDER=$PAI_CODE_FOLDER/Modules
PAI_EXTERNAL_SCRIPT_FOLDER=$PAI_CODE_FOLDER/external-scripts

#PAI_SCRIPT_GUID=$(uuidgen)
PAI_SCRIPT_ID=3C1F2ED5-C28A-40EF-833E-9D93B8502C6E

. ./pai.sh

# PAI functions

pai_3C1F2ED5-C28A-40EF-833E-9D93B8502C6E_intro() {
#	touch $PAI_CONFIG_FILE
	pai_log_sep
	pai_log 'starting pai-install...'
}

pai_3C1F2ED5-C28A-40EF-833E-9D93B8502C6E_validate_folders() {
	pai_log_sep
	pai_log 'Validate and creating folders'
	pai_validate_folder $PAI
	pai_validate_folder $PAI_BACKUP_FOLDER
	pai_validate_folder $PAI_BACKUP_MYSQL_FOLDER
	pai_validate_folder $PAI_BOT_FOLDER
	pai_validate_folder $PAI_CONFIG_FOLDER
	touch $PAI_CONFIG_FILE
	pai_validate_folder $PAI_LOGS_FOLDER
	pai_validate_folder $PAI_SYSTEM_FOLDER
	pai_validate_folder $PAI_CODE_FOLDER
	pai_validate_folder $PAI_CODE_MODULE_FOLDER
	pai_validate_folder $PAI_STARTUP_FOLDER
	pai_validate_folder $PAI_EXTERNAL_SCRIPT_FOLDER

	chmod -R 777 $PAI_LOGS_FOLDER
	chmod -R 777 $PAI_CODE_FOLDER
	chmod -R 777 $PAI_CONFIG_FOLDER
}

pai_validate_folders_copy() {
	pai_log_sep
	pai_log 'Validate and creating folders'
	cp -R ../System/* $PAI_SYSTEM_FOLDER
	cp -R ../Startup/* $PAI_STARTUP_FOLDER
	cp -R ../PAI-CODE/external-scripts/* $PAI_EXTERNAL_SCRIPT_FOLDER
}

pai_3C1F2ED5-C28A-40EF-833E-9D93B8502C6E_update_config_file() {
	echo "OS GUID: $PAI_SCRIPT_ID" >> $PAI_CONFIG_FILE
	echo Installation time: "$(date)" >> $PAI_CONFIG_FILE
}

pai_3C1F2ED5-C28A-40EF-833E-9D93B8502C6E_end() {
	pai_log 'done :)'
}

# PAI main flow

pai_3C1F2ED5-C28A-40EF-833E-9D93B8502C6E_intro
pai_3C1F2ED5-C28A-40EF-833E-9D93B8502C6E_validate_folders
pai_validate_folders_copy
pai_3C1F2ED5-C28A-40EF-833E-9D93B8502C6E_update_config_file
pai_3C1F2ED5-C28A-40EF-833E-9D93B8502C6E_end
