#!/bin/bash

if [[ -e "NetStat_Output.txt" ]]; then
  printf "%s\n" "NetStat_Output Old Log File"
  netstat -a > NetStat_Output.txt
else
  printf "%s\n" "Creating NetStat_Output.txt\n"
  touch NetStat_Output.txt
  printf "%s\n" "running network command"
  netstat -a > NetStat_Output.txt
fi
