#!/bin/bash
greetings="Hello World"
pattern=${greetings#H}
printf "${pattern} with #H, the first letter is removed, if we give He then He will be removed (case sensitive)"
echo "this is called prefix param expansion"

pattern_new=${greetings%rld}
echo "This example is for suffix param expansion, we need to use %<letters> if we give rld then rld from the end will be removed"
echo ${pattern_new}

#longest prefix
file_path="/usr/bin/my_files/file.txt"
dir_path=${file_path##*/} # double hash is used to find the last occurance of ch in the string
echo ${dir_path}
# use the prefix one to get the path of file, use suffix one to remove extesion of the file
file_name=${file_path%%.*}
echo "${file_name}"
