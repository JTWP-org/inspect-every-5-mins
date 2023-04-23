#!/bin/bash

#FINDS THE CURRENT DIR 
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

#MAKES A BACKUP OF THE FILE B4 EDIT IN UR CURRENT DIR 
crontab -l > crontab.bak 

#GETS A CURRENT CRONJOB FILE adds thhe new job and writes it to the file 
# its set to run every 5 mins for more info 
#https://linux.die.net/man/5/crontab

(crontab -l ; echo "*/5 * * * *bash ${SCRIPT_DIR}/inspect.sh") | crontab -
