#!/bin/bash
source config.sh

echo 
function slowcat(){ while read; do sleep .05; echo "$REPLY"; done; }
cat  $1 | slowcat | nc ${serverIp} ${serverPort}
