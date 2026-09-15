#!/bin/bash
find_pattern() {
for file in ${files[@]}
do
    if [[ $file == ${1} ]]
    then
        echo $file
    fi
done
}

files=("file1" "file2" "file3" "file4")
pattern1="file[1-2]"
find_pattern "$pattern1"
pattern2="file[2-3]"
find_pattern "$pattern2"
files=("filea1" "filea2" "fileb3" "fileb4")
pattern3="file[a][1-2]"
find_pattern "$pattern3"

