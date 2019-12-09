#!/bin/sh

printf "What is the input string? "
read input
len=${#input}
case $len in
 1) suffix="" ;;
 *) suffix="s" ;;
esac
echo "$input has $len character$suffix."
