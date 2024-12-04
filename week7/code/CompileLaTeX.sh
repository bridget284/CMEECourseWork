#!/bin/bash
# Author: Bridget Smith bs2324@ic.ac.uk
# Script: complileLaTeX.sh
# Desc: bash script to compile a latex code file called main.tex into a pdf
# Arguments: latex file main.tex (any figures called in main.tex must also be present)
# Output: main.pdf in the results folder
# Date: Dec 2024

# Compile the LaTeX file
pdflatex -output-directory "../results" "main.tex" 
pdflatex -output-directory "../results" "main.tex" # Run pdflatex a second time to ensure all references and links are updated

# Open the PDF output automatically 
evince "../results/main.pdf" &

# Cleanup intermediate files in the results directory
rm ../results/*.aux
rm ../results/*.log
