#!/bin/bash

IPADDRESS="192.168.0.1"
echo "$IPADDRESS" > /app/rfriends3/rfriends3_server.txt
bash /app/rfriends3/rfriends3_server.sh

