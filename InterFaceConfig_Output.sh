#!/bin/bash

if [[ -e "InterFaceConfig_Output.txt" ]]; then
  printf "%s\n" "InterFaceConfig_Output Old Log File"
  ifconfig -a > InterFaceConfig_Output.txt
else
  printf "%s\n" "Creating InterFaceConfig_Output.txt\n"
  touch InterFaceConfig_Output.txt
  printf "%s\n" "running network command"
  ifconfig -a > InterFaceConfig_Output.txt
fi
