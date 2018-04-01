#!/bin/bash
getsysteminfo ()
{
  echo "--- Hardware ---"
  CPU=`cat /proc/cpuinfo | grep 'model name' | uniq |awk -F':' '{print $2}' `
  echo "CPU: $CPU"
  MEMORY=`free -h|grep Mem|awk '{print $2}'`
  echo "RAM: $MEMORY"


#  MOM= 
  MOM1="`dmidecode -s baseboard-manufacturer`"
  MOM2="`dmidecode -s baseboard-product-name `"
   if [ -z "$MOM1" ]; then
    MOM1="Unknown"
   fi
   if [ -z "$MOM2" ]; then
    MOM2="Unknown"
   fi
  echo "Motherboard: $MOM1 $MOM2"



  SERIAL=`dmidecode -s system-serial-number`

   if [ -z "$SERIAL" ]; then
    SERIAL="Unknown"
   fi
  echo "System Serial Number: $SERIAL"
  echo "--- System ---"
  . /etc/lsb-release
  echo "OS Distribution: $DISTRIB_DESCRIPTION"
  KERNEL=`uname -r`
  echo "Kernel version: $KERNEL"
  DATE=`ls -clt / | tail -n 1 | awk '{ print $7, $6, $8 }'`
  echo "Installation date: $DATE"
  HOSTNAME=`hostname`
  echo "Hostname: $HOSTNAME"
  UPTIME=`uptime -p`
  echo "Uptime: $UPTIME"
  PROCESSES=`ps auxf | wc -l`
  echo "Processes running: $PROCESSES"
  USERS=` who |wc -l`
  echo "Users logged in: $USERS"
  echo "--- Network ---"
  IFACES=`ifconfig -a |grep -v -E "^    "|awk '{print $1}'|grep -v -E "^$"`
   for IFACE in $IFACES; do
#    ip addr show $IFACE|grep " inet "
  ADDR=`ip addr show $IFACE|grep " inet "`
     if [ -z "$ADDR" ]; then
      echo "${IFACE}: -"
     else
##echo hell
     echo ${IFACE}: `echo $ADDR|awk '{print $2}'`
     fi
#    echo $IFACE
     done
#  NETWORKS=`ifconfig -a | grep Link -A 1`
#  echo "network: $NETWORKS"
}
#maybe >>? 
getsysteminfo > task4_1.out





