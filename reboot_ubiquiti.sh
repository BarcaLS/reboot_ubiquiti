#!/bin/sh
# reboot_ubiquiti.sh
#
# Script which reboots Ubiquiti devices in you LAN network.
#
# 1) Logging via keys is highly recommended.
#    You can authorise machine running this script (e.g. NAS server in LAN) to logging via SSH and keys to
#    every Ubiquiti device. Just open Cloud Key and go to Settings > Site > Device Authentication and add
#    your machine's ~/.ssh/id_dsa.pub key (home dir of user which will be running this script). Also be sure
#    to previously, manually log into all devices to write them to known_hosts.
# 2) Run it e.g. via cron.

############
# Settings #
############

# Ubiquiti devices to be rebooted: arbitrary name, IP
# E.g.: "USG" 192.168.66.1
PARAMETERS=(
    "AP Small Room" 192.168.1.32
    "AP Kitchen" 192.168.1.48
)

# User on Ubiquiti devices with SSH access by key
SSH_USER="user"

# Command to execute
COMMAND="reboot"

#############
# Main Part #
#############

QUANTITY_OF_PARAMETERS=${#PARAMETERS[@]}
COUNTER=-2
NAME=()
IP=()
while [ ! "$COUNTER" = "$QUANTITY_OF_PARAMETERS" ]
do # let's get all remote addresses
    NAME+=("${PARAMETERS[$COUNTER + 2]}")
    IP+=("${PARAMETERS[$COUNTER + 3]}")
    COUNTER=`expr $COUNTER + 2`
done

while [ $COUNTER != 0 ]; do
    echo "::: Executing \"$COMMAND\" on $SSH_USER@${IP[$COUNTER_TMP]} (${NAME[$COUNTER_TMP]})."
    ssh -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -f ${IP[$COUNTER_TMP]} -l $SSH_USER "$COMMAND" &>/dev/null
    COUNTER=`expr $COUNTER - 2`
    COUNTER_TMP=`expr $COUNTER_TMP + 1`
done
echo "::: Ended."
