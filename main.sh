#!/usr/bin/env bash

download(){
  printf "Enter a website\n"
  read aWebsite
  wget "$aWebsite"
  curl "$aWebsite"
}

ipAddresses() {
    iftop | more
    ifconfig eth0 | more
    ifconfig lo | more
    ifconfig wlan0 | more
    ip a | more
    ip addr | more
    ip a show eth0 | more  
    ip a show lo  | more
    ip a show wlan0 | more
    iwconfig | more
}

traceIT(){
  traceroute google.com
  traceroute -n google.com
  traceroute -T google.com
  traceroute -I google.com

  tracepath mindmajix.com
  ping google.com
  dig google.com
  dig google.com MX
  dig google.com ANY
  nslookup mindmajix.com
  host mindmajix.com
}

prg_w_open_socket(){
    netstat -p
    netstat -s
    ss -ta  
    ss -ua  
    ss -xa 
    ss -lt  
    ss -lu  
    ss -lx
    ss -t4 state established
    ss -t4 state closed
}

routing_table(){
  netstat -r
  route
  route -n
  route -Cn
  arp -a
}

selection(){
  if [[ $1 == n ]]; then
    exit
  else
    clear
  fi
}

d="=============================="
divider1=$d$d
t="Network Program"
h="Network Information"
user="$(whoami)"
lcl="$(pwd)"
d2="------------------------------"
divider2=$d2$d2
d3="------------------------------"
divider3=$d3$d3
p="Please enter your choice:"
choice1="Ip | MAC | Netmask (1)"
choice2="Trace It           (2)"
choice3="Open Ports         (3)"
choice4="Route              (4)"
choice5="Download           (5)"
choice6="Quit               (6)"

while :
do
    clear
    
    printf "%-$width.${width}s\n" "$divider1"
    printf "%75s\n" ""
    printf "%75s\n" "$user"
    printf "%75s\n"  "$lcl"
    printf  "%-$width.${width}s\n" "$divider2" 
    printf "%75s\n" "$p" 

    printf "%-75s\n" "$choice1"
    printf "%-75s\n" "$choice2"
    printf "%-75s\n" "$choice3"
    printf "%-75s\n" "$choice4"
    printf "%-75s\n" "$choice5"
    printf "%-75s\n" "$choice6"    
    printf "%-$width.${width}s\n" "$d3"
  read Selection
  case "$Selection" in
    1)ipAddresses
      sleep 5
      ;;
    2)traceIT
      sleep 5
      ;;
    3)prg_w_open_socket
      sleep 5
      ;;
    4)routing_table
      sleep 5
      ;;
    5)download
      ;;
    6)exit
      ;;
    *)printf "make a valid choice"
      sleep 5
      ;;
  esac

  printf "Continue? (y|n)\n"
  read -n 1 ans
  selection "$ans"

done