#!/bin/bash

rconPort="9100"
serverIp="127.0.0.1"
rconPassWord="PASSWORD123"
#not md5 or if u want to use md5 just comment the next line out and uncoomment the one below 

HASH=$(echo -n "${rconPassWord}" | md5sum)
#HASH="MD5 PASSWORD"
