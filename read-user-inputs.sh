#!/bin/bash
read -p "Enter your name:" name
echo "Hello" $name
# Script is executed as ./read-user-inputs.sh "some-text"
echo "The details in this script are, 
        script name: $0
        script param: $1
    "
# $0 prints the script name itself
# $1 prints the first param/arg passed to the script