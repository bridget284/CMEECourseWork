#!/bin/bash
# Author: Bridget Smith bs2324@ic.ac.uk
# Script: ComplileLaTeX.sh
# Desc: bash script to compile a latex code file called into a pdf
# Arguments: the .tex file for the pdf
# Output: a pdf in the results folder
# Date: Dec 2024

# Compile the LaTeX file
pdflatex $1
bibtex ${1%.*}
pdflatex $1
pdflatex ${1%.*}
mv ${1%.*}.pdf ../results/${1%.*}.pdf
evince ../results/${1%.*}.pdf &

## Cleanup
rm *.aux
rm *.log
rm *.bbl
rm *.blg