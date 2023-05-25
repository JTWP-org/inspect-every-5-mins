#!/bin/bash
source config.sh

#make password MD5
HASH=$(echo -n "${rconPassWord}" | md5sum | tr  -d '    ,\-,    ')

#FINDS THE CURRENT DIR 
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

#FILE NAME FOR OUTPUT
Fname="inspectPlayer-$( date "+%m-%d-%Y-%R")"
#runs the setup the first time then turns it off so it wont run again unless u set it true again 

if [ "$setUp" = "true" ]; then

    

    #MAKES A BACKUP OF THE FILE B4 EDIT IN UR CURRENT DIR 
    crontab -l > crontab.bak 

    #GETS A CURRENT CRONJOB FILE adds thhe new job and writes it to the file 
    # its set to run every 5 mins for more info 
    #https://linux.die.net/man/5/crontab

    (crontab -l ; echo "*/5 * * * *bash ${SCRIPT_DIR}/inspect.sh") | crontab -

    #this turns the var for the setup in config off after the first setup
    sed -i 's/setUp="true"/setUp="false"/' config.sh
fi

    #build first batch file to get players steamids
    echo -e "${HASH}\nRefreshList\ndisconnect" > batch0.txt
    cat batch0.txt | head -n1 > batch1.txt
    serverinfo
    sleep 3
    echo wait 3 seconds
    bash ${SCRIPT_DIR}/nc.sh ${SCRIPT_DIR}/batch0.txt | tail -n +2 | sed '$ d' | jq ' .PlayerList | .[] | .UniqueId ' | tr -d "\"" > playersNOW.txt 

cat playersNOW.txt | while read line 
do
   $(echo "InspectPlayer $line" >> batch1.txt) 1> /dev/null
done
echo -e "disconnect" >> batch1.txt

bash ${SCRIPT_DIR}/nc.sh batch1.txt > "$SCRIPT_DIR/log/$Fname.json" 
