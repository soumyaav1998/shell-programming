#!/bin/bash
for i in {1..10}
do
    echo $i 
done

for i in a,b,c
do
    echo $i 
done

# Count lines in each file in a current dir
# ls command to list the files
# cat each file and wc -l to count lines in that file

for file in $(ls)
do
    echo "file name $file" $(cat $file | wc -l)
done
