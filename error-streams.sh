#!/bin/bash
ls "myfile.txt" > /dev/null 2>&1
# or
ls "myfile.txt" 1> /dev/null 2>&1

# > is same as 1>

# ls "myfile.txt": Looks for the file.> /dev/null: If the file exists, the success output is sent to /dev/null (the system's "black hole" or trash bin where data is instantly deleted).
# 2>&1: If the file doesn't exist, the error message (2) is redirected to wherever stream 1 is going (which is /dev/null).