#!/bin/bash
# Author: Bridget Smith bs2324@ic.ac.uk
# Script: tiff2png.sh
# Desc: a script which converts a tiff file to a png file
# Arguments: a tiff file
# Output: this script converts the tiff file to a png file
# Date: Oct 2024

if ! command -v convert &> /dev/null
then
    echo "ImageMagick's 'convert' command could not be found. Please install ImageMagick to use this script."
    exit 1
fi

for f in *.tif;
    do 
        echo "Converting $f";
        convert "$f" "$(basename "$f" .tif).png";
    done