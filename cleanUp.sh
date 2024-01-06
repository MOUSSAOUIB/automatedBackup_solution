#!/bin/bash

#directory="/home/moussaoui/automatedBackup_solution/dir"
directory="{{ local_backup_path }}"

# Count the number of files in the directory
num_items=$(ls -1 $directory | wc -l)

echo "num_items = $num_items" 
# Number of files to keep
keep=2

let "delete = $num_items - $keep"

echo " delete = $delete"

# echo "--debuging--"
# ls $directory -t | tail -n $delete | while IFS= read -r item; do echo "items are $item" ;done

# Check if there are  files to delete
if [ "$delete" -gt 0 ]; then
    # Delete the oldest backup files
    ls $directory -t | tail -n $delete  |  while IFS= read -r item; do rm -rf $directory/$item; done
fi
