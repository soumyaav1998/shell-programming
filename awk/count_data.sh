#!/bin/bash
awk '{ print "No. of columns in row " NR " is " NF }' sample.txt
awk '{ print FILENAME }' sample.txt