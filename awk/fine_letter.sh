#!/bin/bash
# We will make use of awk command to find a letter in the sample.txt file
# AWK Command proccesses columns first then rows
# we will find letter L from the sample.txt file located at 2nd column 3rd row
awk 'NR == 3 { print $2 }' sample.txt
# NR is a built in variable that rep. rows in the file 
# columns are called fields and rows are called lines
# for lines having 2 or more fields(columns) print the second field
contents=$(awk 'NF >= 2 { print $2 }' sample.txt)

echo "$contents"

# prints 2nd column of top command
top | awk '{ print $2 }' | head -n 5
# print capacities of disk space used 100%
left_capacity=$(df | awk '{print $5 }' | tail -n +2)
for capacity in $left_capacity
do
    if [[ $capacity == "100%" ]]
    then
        echo "capacitty reached to 100% at least once"
        exit 1
    fi
done


#awk syntax
# awk '{}' <input>
# '{}' is called as action block after which awk expects an input
# awk is a domain specific language. we can also have .awk files and write code in awk language in them
# and we should not use shebang but use /usr/bin/awk at the top of file 