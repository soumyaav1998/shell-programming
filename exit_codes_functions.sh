#!/bin/bash
echo "This is a default var where shell stores exit codes and default value is 0" $?
echo "When we use the return statement in shell, it always updates the value of "\$?" command"

function add() {
    echo $(( $1 + $2 ))
}
sum=$( add 2 3 )
echo "$sum"

function addnew() {
    return $(( $1 + $2 ))
}
addnew 2 4
sum=$?
echo "$sum"
