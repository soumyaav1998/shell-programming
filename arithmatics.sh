#!/bin/bash
# Using $(expr expression)
A=10
B=20
C=$(expr $A + $B)
D=$(expr $A \* $C)
E=$(expr $A / $B)
echo $C $D $E

#using double parenthesis $(())
F=5
G=10
I=$(($F + $G))
J=$(($F * $G))
K=$(($G / $F))
echo $I $J $K

#To get floating number output, use "bc -l utility"

L=10
M=3
echo $L / $M | bc -l