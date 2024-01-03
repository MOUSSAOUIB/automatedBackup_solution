#!/bin/bash

# Directory containing the backup folders
#backup_dir="/cluster/brf/backup"

# Remote server details
remote_user="admin"
remote_host1="{{ remote_host }}"
LOCAL_BACKUP_PATH="{{ local_backup_path }}"
REMOTE_BACKUP_PATH="{{ remote_backup_path }}"
#remote_dir="/backup/MTAS"

# Find the most recent backup directory
most_recent_backup_SYS=$(ls -l $LOCAL_BACKUP_PATH | grep '^d' | awk '{print $9}' | grep '^BACKUP-SYS_' | sort -r | head -n 1)
most_recent_backup_USER=$(ls -l $LOCAL_BACKUP_PATH | grep '^d' | awk '{print $9}' | grep '^BACKUP-USER_' | sort -r | head -n 1)

# Check if a backup directory was found
if [ -z "$most_recent_backup_SYS" ]; then
    echo "No SYS backup directory found."
    exit 1
fi

if [ -z "$most_recent_backup_USER" ]; then
    echo "No USER backup directory found."
    exit 1
fi

# Full path to the most recent backup directory
full_backup_SYS_path="$LOCAL_BACKUP_PATH/$most_recent_backup_SYS"
full_backup_USER_path="$LOCAL_BACKUP_PATH/$most_recent_backup_USER"


# Use scp to copy the most recent backup directory to Backup servers
#--CASA--
scp -r "$full_backup_SYS_path" "$remote_user@$remote_host1:$REMOTE_BACKUP_PATH"
scp -r "$full_backup_USER_path" "$remote_user@$remote_host1:$REMOTE_BACKUP_PATH"
#--RABAT--
#scp -r "$full_backup_SYS_path" "$remote_user@$remote_host2:$REMOTE_BACKUP_PATH"
#scp -r "$full_backup_USER_path" "$remote_user@$remote_host2:$REMOTE_BACKUP_PATH"

#echo "Backup $most_recent_backup_SYS has been sent to $remote_host1:$REMOTE_BACKUP_PATH"
#echo "Backup $most_recent_backup_USER has been sent to $remote_host1:$REMOTE_BACKUP_PATH"

