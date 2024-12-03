#!/bin/sh
# Author: Bridget Smith bridget.smith24@imperial.ac.uk
# Script tabtocsv.sh
# Description: substitute the tabs in the files with commas
# Saves the output to a csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 2024

# check if output file exists, if it does then exit
if [ -f "$1.csv" ] 
then
    echo "Error: The file '$1.csv' already exists."
    echo "Please remove it or rename it before running this script."
    exit 1
fi


# check there is 1 file as input
if [ $# -eq 1 ] && [ -f "$1" ] 
then
    echo "Creating a comma delimited version of $1 ..."
    # convert tab-delimited file to a comma-separated vales file
    cat $1 | tr -s "\t" "," >> $1.csv 
echo "Done!"
else 
    echo "Wrong number of arguments present, please use one file."
fi
exit