#!/bin/sh
# Author: Bridget Smith bs2324@ic.ac.uk
# Script: variables.sh
# Desc: a script which shows examples of variables
# Arguments: 0 to 3 user input variables
# Output: examples of variables
# Date: Oct 2024

# Special variables
echo "This script was called with $# parameters"
echo "The script's name is $0"
echo "The first argument is $1"
echo "the second argument is $2"

# Assigned variables; explicit declaration
MY_VAR='some string'
echo 'the current value of the variable is:' $MY_VAR
echo
echo 'Please enter a new string'
read MY_VAR
echo 
echo 'the current value of the variable is:' $MY_VAR
echo

# Assigned variables; reading multiple values from us
echo 'Enter two numbers separated by space(s)'
read a b
echo
echo 'you entered' $a 'and' $b '; their sum is:'

# Assigned variables; command substitution
MY_SUM=$(expr $a + $b)
echo $MY_SUM
