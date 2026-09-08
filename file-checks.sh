#!/bin/bash
# To check if a file exits
filename=test-file.txt
if [ -f "$filename" ]
then
echo "file exists"
fi

# To check if file is not empty (size > 0)
if [ -s "$filename" ]
then
echo "file not empty"
else
echo "file empty"
fi

#check if path is dir
if [ -d "$filename" ]
then
echo "path is a dir"
else
echo "not a dir"
fi

#check if file is executable
exefile="test.sh"
if [[ -x $exefile ]]
then
echo "script is executable"
else
echo "not executable"
fi

#use -w flag to check if file is writable

readonly TEST_FILE="test-file.sh"
if [[ -f ${TEST_FILE} ]]
then
echo "file exists"
source ${TEST_FILE}
fi
