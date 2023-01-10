#!/bin/bash

printf "%s\n" "Running Network Bash Script"

if [[ -e "networkProgramOutput.txt" ]]; then
  printf "%s\n" "Overwriting Old Log File"
  nmcli con show eth1 | grep IP4.ADDRESS > networkProgramOutput.txt
else
  printf "%s\n" "Creating new logfile\n"
  touch networkProgramOutput.txt
  printf "%s\n" "running network command"
  nmcli con show eth1 | grep IP4.ADDRESS > networkProgramOutput.txt
fi

if [[ -e "InterFaceConfig_Output.txt" ]]; then
  printf "%s\n" "InterFaceConfig_Output Old Log File"
  nmcli con show eth1 | grep IP4.ADDRESS > networkProgramOutput.txt
else
  printf "%s\n" "Creating InterFaceConfig_Output.txt\n"
  touch networkProgramOutput.txt
  printf "%s\n" "running network command"
  ifconfig -a > InterFaceConfig_Output.txt
fi
