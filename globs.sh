#!/bin/bash
# Question Mark
files=("test1.txt" "test2.txt" "something.txt")
for file in ${files[@]}
do
    if [[ ${file} == test?.txt ]]
    then
        echo ${file}
    fi
done

# \ symbol
# if we want to access any character as a regular character we use \ before it like \?
# ls \?ail
# use \\ to escape spl characters like if u want to spot a ? in a txt then use \\?
# if u want to spot \? in a text then use \\?


# Array containing the sample strings from the image
files=(
    "fa_\il.txt"
    "ha2\il.doc"
    "4a1-1\il.txt"
    "R *al.py"
)

# The glob pattern from the image: ?a*\\il.???
# ?   -> matches a single character (f, h, 4, R)
# a   -> matches literal 'a'
# *   -> matches zero or more characters (_, 2, 1-1,  )
# \\  -> matches a literal backslash '\'
# il. -> matches literal string 'il.'
# ??? -> matches a 3-character extension (.txt, .doc)

pattern='?a*\\il.???'

for file in "${files[@]}"
do
    if [[ "$file" == $pattern ]]
    then
        echo " MATCH : $file"
    else
        echo "❌ FAIL  : $file"
    fi
done
