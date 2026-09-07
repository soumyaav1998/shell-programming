#!/bin/bash
i=10
while ((i != 1))
do
    i=$(( $i - 1 ))
    echo $i
done

while true
do
    echo "option 1: Shutdown"
    echo "option 2: Restart"
    echo "option 3: Reboot"
    read -p "Enter from options 1 through 3: " input
    if [ $input -eq 1 ]
    then
        echo "option selected is Shutdown"
        break
    elif [ $input -eq 2 ]
    then
        echo "option selected is Restart"
        break
    elif [ $input -eq 3 ]
    then
        echo "option selected is Reboot"
        break
    else
        continue
    fi
done
