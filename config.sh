#!/bin/bash

rconPort="9100"
serverIp="127.0.0.1"
rconPassWord="PASSWORD123"
#not md5 or if u want to use md5 just comment line #9 out with a # at the start and
remove the leading # on line 10

HASH=$(echo -n "${rconPassWord}" | md5sum)
#HASH="MD5 PASSWORD"
