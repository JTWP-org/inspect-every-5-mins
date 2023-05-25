#!/bin/bash
#script here was not made by me the slowcat was written by invicta_nz#6872 and found in OLD wiki 

source config.sh
 
function slowcat(){ while read; do sleep .05; echo "$REPLY"; done; }
cat  $1 | slowcat | nc ${serverIp} ${rconPort}


