#!/bin/bash

while true
do
    echo "option 1: Shutdown"
    echo "option 2: Restart"
    echo "option 3: Reboot"
    read -p "Enter from options 1 through 3: " input

    case $input in
        1) echo "shutdown"; break ;; # break stops the loop when valid
        2) echo "restart"; break ;;
        3) echo "reboot"; break ;;
        *) echo "Invalid choice, please try again."; continue ;; # continue loops back up
    esac
done

# break and continue statements cannot be used in the case loop alone, they should be part of for or while loops