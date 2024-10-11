#!/bin/bash
# Author: Bridget Smith bridget.smith24@imperial.ac.uk
# Script: ConcatinateTwoFiles.sh
# Description: .sh file which can concatinate two seperate files
# Arguments: two files
# Output: creates one new file
# Date: Oct 2024

if [ $# -eq 2 ] && [ -f "$1" ] && [ -f "$2" ]
then
    cat $1 > $3
    cat $2 >> $3
    echo "Merged File is"
    cat $3
else 
    echo "Wrong number of arguments present, please use two files."
fi