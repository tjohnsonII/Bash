#!/usr/bin/env bash

#Shell Script Options
#set -x
set -Eeuo pipefail

#Error Handling
trap cleanup SIGINT SIGTERM ERR EXIT

#variables
USER=$(whoami)
ROOT="root"
S_DIR="/home/tim2/timScripts"
C_DIR=$(pwd)
scriptDirectory="$(basename -- "$S_DIR")"
currentRunningScript="$0"
networkLog="networkCheck.txt"
ipArchive="ipAddresses.txt"
webSITES="urls.txt"
genericLogs="^(logfil[0-9])"
FILES=$(ls -a)
FILE_TYPES=("Readable" "Writable" "Execute" "Symlink" "Directory" "Main Menu")
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'
NETWORK_OPTIONS=("Ping" "Interface Configuration" "ARP" "Netstat" "Traceroute" "Dig" "Main Menu")
WebSite="google.com"
URL="https://www.google.com"
OPERATING_SYSTEM=$(uname)
OS_MAC="Darwin"
TITLE="Info Script"
PROMPT="Make a selection"
OPT1="Are You Root?"
OPT2="Disk Space Free"
OPT3="Disk Utilization"
OPT4="List Files"
OPT5="Check File Type?"
OPT6="Does the File Exist?"
OPT7="List File Sizes?"
OPT8="Check The Network?"
OPT9="Quit"
OPTIONS=("$OPT1" "$OPT2" "$OPT3" "$OPT4" "$OPT5" "$OPT6" "$OPT7" "$OPT8" "$OPT9")
U_INPUT=""

#functions
cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
  if [[ -e $networkLog ]]; then
    printf "%s\n" "${red}Removing Old Log Files${end}"
    rm -f networkCheck.txt
  fi
  
  if [[ -e $ipArchive ]]; then
    printf "%s\n" "${red}Removing Old Log Files${end}"
    rm -f ipAddresses.txt
    rm -f ipArchive
  fi
  
  if [[ -e $webSITES ]]; then
    printf "%s\n" "${red}Removing Old Log Files${end}"
    rm -f urls.txt
  fi
  
  for i in $FILES; do
    if [[ $i =~ $genericLogs ]]; then
      printf "%s\n" "${red}Removing Old Log Files $i ${end}"
      rm -f log*
    fi
  done
}

are_u_root() {
    if [[ $USER == "$ROOT" ]]; then
  	  printf "%10s\n" "${red}You are the Root User${end}"
    elif [[ $USER != "$ROOT" ]]; then
  	  printf "%10s\n" "${grn}Current User: $USER${end}"
    fi
}

move_to_home_script(){
  if [[ $OPERATING_SYSTEM == "$OS_MAC" ]]; then
    cd /Users/Shared/timScripts || exit
  else
    cd /home/tim2/Scripts || exit
  fi
  printf "Currnet File Location: %s\n" "${red}$C_DIR${end}"
}

script_Directory(){
    printf "%s\n" "Script Directory: ${cyn}$scriptDirectory${end}"
}

currentScript(){
  printf "%s\n" "Current Running Script: ${yel}$currentRunningScript${end}" 
}

logFile(){
  if [[ -e $networkLog ]]; then
    printf "%s\n" "${red}Removing Old Log Files${end}"
    rm -f networkCheck.txt
    printf "%s\n" "${grn}Creating New Empty Log File${end}"
    cat /dev/null > networkCheck.txt
  else
    printf "%s\n" "${grn}Creating Empyt LogFiles${end}"
    cat /dev/null > networkLog.txt
  fi
  
  if [[ -e $ipArchive ]]; then
    printf "%s\n" "${red}Removing Old Log Files${end}"
    rm -f ipAddresses.txt
    rm -f ipArchive
    printf "%s\n" "${grn}Creating New Empty Log File${end}"
    cat /dev/null > ipAddresses.txt
  else
    printf "%s\n" "${grn}Creating Empyt LogFiles${end}"
    cat /dev/null > ipAddresses.txt
  fi
  
  if [[ -e $webSITES ]]; then
    printf "%s\n" "${red}Removing Old Log Files${end}"
    rm -f urls.txt
    printf "%s\n" "${grn}Creating New Empty Log File${end}"
    cat /dev/null > urls.txt
  else
    printf "%s\n" "${grn}Creating Empyt LogFiles${end}"
    cat /dev/null > urls.txt
  fi
  
  for i in $FILES; do
    if [[ $i =~ $genericLogs ]]; then
      printf "%s\n" "${red}Removing Old Log Files $i ${end}"
      rm -f log*
      printf "%s\n" "${grn}Creating New Empty Log File${end}"
      cat /dev/null > logFile.txt
    else
      printf "%s\n" "${grn}Creating Empyt LogFiles${end}"
      cat /dev/null > logFile.txt
    fi
  done

  cleanup
}

check_fileType(){
  printf "%20s\n" "${grn}$PROMPT${end}"
  select file_type in "${FILE_TYPES[@]}"
  do 
    case $file_type in
      "Readable")
          for i in $FILES; do
            if [[ -r $i  ]]; then
              printf "Is readable file: %s\n" "${blu}$i${end}"
            else
              printf "Is not readable files: %s\n" "${red}$i${end}"
            fi
          done
          keep_Going
      ;;
      "Writable")
          for i in $FILES; do
            if [[ -w $i  ]]; then
              printf "Is writable file: %s\n" "${grn}$i${end}"
            else
              printf "Is not writable files: %s\n" "${red}$i${end}"
            fi
          done
          keep_Going
      ;;
      "Execute")
          for i in $FILES; do
            if [[ -x $i  ]]; then
              printf "Is executable file: %s\n" "${cyn}$i${end}"
            else
              printf "Is not excutable file: %s\n" "${red}$i${end}"
            fi
          done
          keep_Going
      ;;
      "Symlink")
        for i in $FILES; do
            if [[ -h $i  ]]; then
              printf "Is symlink file: %s\n" "${mag}$i${end}"
            else
              printf "Is not symlink file: %s\n" "${red}$i${end}"
            fi
        done
      ;;
      "Directory")
        for i in $FILES; do
          if [[ -d $i  ]]; then
            printf "Is a Directory: %s\n" "${grn}$i${end}"
          else
            printf "Is not a Directory: %s\n" "${red}$i${end}"
          fi
        done
        keep_Going
      ;;
      "Main Menu")
        return_ToMain
        ;;
    esac
  done
}

file_Exist(){
    for i in $1; do
      if [[ -r $i  ]]; then
        printf "File: %s Exist \n" "${grn}$i${end}"
      else
        printf "File: %s Does not exist \n" "${red}$i${end}"
      fi
    done
}

file_Size(){
  for i in $FILES; do
      if [[ -s $i  ]]; then
        printf "File: %s > 0 Bytes \n" "${blu}$i${end}"
        printf "Word Count of %s is: %s \n" "$i" "$(wc -w "$i")"
      else
        printf "File: %s < 0 Bytes \n" "${red}$i${end}"
      fi
  done 
}

check_network(){
  printf "%50s\n" "${grn}Networking Status and Utility${end}"
  select a_command in "${NETWORK_OPTIONS[@]}"
  do
    case $a_command in
      "Ping")
          printf "%s\n" "${grn}Ping Command executing: ping -c 1 $URL${end}"
          printf "%s\n" "${grn}Enter a website or ip address${end}"
          read -r WebSite
          if ping -c 1 "$WebSite" >> $networkLog; then
            printf "%s\n" "${grn}It appears you have a working internet connection${end}"
          else
            printf "%s\n" "${red}There is a network issue or invalid website/ip address ${end}"
          fi
          grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' $networkLog > $ipArchive
      ;;
      "Interface Configuration")
          printf "%s\n" "${grn}Interface Configuration Command executing: ifconfig pa ${end}"
          ifconfig -a
          ifconfig -a | grep inet >> $networkLog
      ;;
      "ARP")
          printf "%s\n" "${grn}Address Resolution Protocol Command executing: apr -a ${end}"
          arp -a
          arp -a &> $networkLog
      ;;
      "Netstat")
          printf "%s\n" "${grn}Netstat Command executing: netstat -a ${end}"
          netstat -a
          netstat -a &> $networkLog
      ;;
      "Traceroute")
          printf "%s\n" "${grn}Traceroute Command executing: traceroute google.com  ${end}"
          printf "%s\n" "${grn}Enter a website or ip adddress${end}"
          read -r WebSite
          traceroute "$WebSite"
          traceroute "$WebSite" &> $networkLog
      ;;
      "Dig")
          printf "%s\n" "${grn}Dig Command executing: dig google.com ${end}"
          printf "%s\n" "Enter a website or ip address"
          read -r WebSite
          dig "$WebSite"
          dig "$WebSite" &> $networkLog
      ;;
      "Main Menu")
          return_ToMain
      ;;
    esac
  done
}

disk_space_free(){
  printf "%s\n" "${grn}The Amount of Disk Space Free: df command${end}"
  df -h
  keep_Going
}

disk_usage_stats(){
  printf "%s\n" "${grn}Disk Utilization Stats${end}"
  du -h
  keep_Going
}

list_the_files(){
  printf "%s\n" "${grn}A list of the files in this directory${end}"
  ls -all
  keep_Going
}

operating_system(){
	printf "%10s\n" "${red}$OPERATING_SYSTEM${end}"
}

Quit_Die(){
  exit
}

keep_Going(){
  printf "%10s" "${grn}Continue?${end}"
  read -r U_INPUT
  if [[ $U_INPUT == "y" ]]; then
    clear
    MainMenu
  elif [[ $U_INPUT == "Y" ]]; then
    clear
    MainMenu
  else
      exit
  fi
}

return_ToMain(){
  clear
  MainMenu
}

MainMenu(){
	printf "%50s\n" "${blu}***************$TITLE********************${end}"
	operating_system
  are_u_root
  move_to_home_script
  currentScript
  script_Directory

  printf "%20s\n" "$PROMPT"
  
  select opt in "${OPTIONS[@]}"
  do
    case $opt in
      "$OPT1") 
        are_u_root
        keep_Going
        ;;
      "$OPT2")
        disk_space_free
        keep_Going
        ;;
      "$OPT3")
        disk_usage_stats
        keep_Going
        ;;
      "$OPT4")
        list_the_files
        keep_Going
        ;;
      "$OPT5")
        check_fileType
        keep_Going
        ;;
      "$OPT6")
        file_Exist aFile.txt
        keep_Going
        ;;
      "$OPT7")
        file_Size
        keep_Going
        ;;
      "$OPT8")
        check_network
        keep_Going
        ;;
      "$OPT9")
        Quit_Die
        ;;
    esac 
  done  
}

#function calls
logFile
MainMenu