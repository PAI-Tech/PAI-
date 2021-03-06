#!/bin/bash

# pai-backup-mysql-db
# Backup DB and keep 7 days
# pai-script-id=8fc5a3dd-ba8d-4cd4-91ce-7e0ae086b245
# Created by Eran Caballero on Mon Jul 23 12:15:27 UTC 2018
# Generated by PAI Linux Bot
# Copyrights PAI Tech INC 2018, all rights reserved

# --add-drop-database

# --single-transaction - Since I am using InnoDB tables, I will want to use this option.

# --add-drop-table - Add DROP TABLE statement before each CREATE TABLE statement

# PAI includes

PAI_SCRIPT_ID=8fc5a3dd-ba8d-4cd4-91ce-7e0ae086b245

PAI=/var/PAI
BACKUP_FOLDER="$PAI/Backup"
DB_BACKUP_FOLDER="$BACKUP_FOLDER/MySQL"
DB_NAME=wordpress
_now=$(date +"%d_%m_%Y-%H.%M")
_file="$DB_BACKUP_FOLDER/$DB_NAME-$_now.sql.gz"

. $PAI/System/pai.sh

# PAI functions

pai_8fc5a3dd-ba8d-4cd4-91ce-7e0ae086b245_intro() {
pai_log_sep
pai_log 'starting pai-backup-mysql-db...'
}

pai_backup_db_dump()
{
        pai_log 'Starting backup to $_file...'
        mysqldump -u root -pjHgNa6IrEzZ4 --default-character-set=utf8mb4 --add-drop-database --add-drop-table --single-transaction  -B --routines $DB_NAME | gzip -9 > $_file
        echo "Databse $DB_NAME succesfully exported to: "
        ls -l $_file
        find $DB_BACKUP_FOLDER/$DB_NAME* -mtime +7 -exec rm {} \;
}

pai_8fc5a3dd-ba8d-4cd4-91ce-7e0ae086b245_end() {
pai_log 'done :)'
}

# PAI main flow

pai_8fc5a3dd-ba8d-4cd4-91ce-7e0ae086b245_intro
pai_backup_db_dump
pai_8fc5a3dd-ba8d-4cd4-91ce-7e0ae086b245_end
