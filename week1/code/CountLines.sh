#!/bin/bash
# Author: Bridget Smith bs2324@ic.ac.uk
# Script: CountLines.sh
# Desc: script which counts the number of lines in a file
# Arguments: one file
# Output: a sentence stating the number of lines in the file
# Date: Oct 2024

# check there is 1 file as input
if [ $# -eq 1 ] && [ -f "$1" ] 
then
    # count the number of lines in a file, print the result
    NumLines=$(wc -l < "$1")
    echo "The file $1 has $NumLines lines"
else 
    # inform user the wrong arguments have been used
    echo "Wrong number of arguments present, please use one file."
fi