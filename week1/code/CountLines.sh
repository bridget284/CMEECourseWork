#!/bin/bash
# Author: Bridget Smith bs2324@ic.ac.uk
# Script: CountLines.sh
# Desc: script which counts the number of lines in a file
# Arguments: one file
# Output: a sentence stating the number of lines in the file
# Date: Oct 2024

NumLines="wc -l < $1"
echo "The file $1 has $NumLines lines"
echo