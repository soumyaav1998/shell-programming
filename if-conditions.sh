#!/bin/bash
# 1st way is to use [] and use -gt -lt etc for integer comparisions
if [ 5 -gt 6 ]
then
    echo "5 gt 6"
else
    echo "6 gt 5"
fi


# 2nd way to combine 2 operations use [[]]
A=10
B=30
if [[ A -lt B && B -eq 30 ]]
then
    echo "true"
else
    echo "false"
fi

#3rd is to do string comparisions using symbols
#if you put bc in "" it will be treated as a string and not an expression anf false will be output

if [[ "abcd" = *bc* ]]
then
echo "true"
else
echo "false"
fi

#check if third ch is either c or d
if [[ "abcd" = ab[cd]* ]]
then
echo "3rd ch is c or d"
fi

# Math operations for int can be done inside (()) and inside (()) you don't need to use dollar sign
A=10
B=-20
C=2
if (( A >= B && A >= C))
then
echo $A 
elif (( $B >= $C && $B >= $A ))
then
echo $B
else
echo $C
fi
