#!/bin/bash
# Author: Bridget Smith bs2324@ic.ac.uk
# Script: csvtospace.sh
# Desc: a script which converts a .csv file to a .txt, space separated file
# Arguments: a .csv file
# Output: this script creates a .txt file
# Date: Oct 2024

# check if output file exists, if it does then exit
if [ -f "$1.txt" ] 
then
    echo "Error: The file '$1.txt' already exists."
    echo "Please remove it or rename it before running this script."
    exit 1
fi

# check there is a single input and that it is a file
if [ $# -eq 1 ] && [ -f "$1" ] 
then
    # change any commas to spaces
    cat $1 | tr -s "," " " >> $1.txt
else 
    # if the inputs are wrong, let the user know and exit
    echo "Wrong number of arguments present, please use one file."
fi
exit