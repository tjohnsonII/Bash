#!/bin/bash

if [[ -e "Arp_Output.txt" ]]; then
  printf "%s\n" "Arp_Output Old Log File"
  arp -a > Arp_Output.txt
else
  printf "%s\n" "Creating Arp_Output.txt\n"
  touch Arp_Output.txt
  printf "%s\n" "running network command"
  arp -a > Arp_Output.txt
fi
