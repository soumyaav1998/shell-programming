#!/bin/bash
awk -F ":" '{ print $1 " " $2 " "  $3 }' sample1.txt
# -F IS USED TO GIVE FIELD SEPARATOR
awk -F ":" -v roll_no="105" '$1 >= roll_no { print " Printing sr no greater than 105: " $1 " " $2 " " $3 }' sample1.txt
