# Week 4 Coursework

## Description 
This repository contains the code, data, and folder structure for Week 4 coursework, organized into separate folders for easy navigation and workflow. This work is from the individual assignment week of the coding bootcamp.

## Language
R
bash
latex

## Dependencies
R version 4.3.3 was used when creating this files, and in R the package dplyr is required.
The LaTeX package used is: graphicx

## Instillation
### R
install.packages("dplyr")
### LaTeX
\usepackage{graphicx} 

## Repository Structure
week4/code/  
Contains 2 R scripts, one LaTeX file and one bash file which can be used to compile the LaTeX file into a pdf in the results folder.
The LaTeX file is called main.tex and is part of the "Is Florida Getting Warmer?"" assignment. 
CompileLaTeX.sh is the bash file.
The R files are Florida.R, PP_Regress.R

week4/data/ 
Contains data files for analysis:
EcolArchives-E089-51-D1.csv and KeyWestAnnualMeanTemperature.RData are used in PP_Regress.R.
Rplot.png is used in main.tex, and the code for this plot is found in Florida.R

week4/results/ 
Empty folder to store output and results from scripts 

week4/sandbox/ 
Folder for experimental code and testing

## Author
Bridget Smith
bs2324@ic.ac.uk

