#!/bin/bash
# Author: Bridget Smith bs2324@ic.ac.uk
# Script: csvtospace.sh
# Desc: a script which converts a .csv file to a .txt, space separated file
# Arguments: a .csv file
# Output: this script creates a .txt file
# Date: Oct 2024

if [ $# -eq 1 ] && [ -f "$1" ]
then
    cat $1 | tr -s "," " " >> $1.txt
else 
    echo "Wrong number of arguments present, please use one file."
fi
exit