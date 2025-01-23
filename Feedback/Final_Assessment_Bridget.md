
# Final CMEE Bootcamp Assessment: Bridget Smith

- Overall project clean and well organised. 
  
- You had an .gitignore, good. You could have done with more exclusions specific to certain weeks (remember that you can include/exclude subdirectories/files/patterns). You may [find this useful](https://www.gitignore.io).

- You had a good overall Readme which gave a sufficient overview of the Repo as a whole, and gave general details of things like languages used. You also had weekly Readme files which went into more details relevant to each week. You could have included versions of languages and dependencies/packages used. Also check out [this resource](https://github.com/jehna/readme-best-practices).


## Week  1


- README lacked sufficient instructions for script usage or dependencies.
- `variables.sh` produced errors when no arguments were provided - could have been improved for better argument / error handling.
- `tiff2png.sh` also lacked error handling for missing input files.

## Week  2


- Results and sandbox folders were utilized appropriately.
- `.gitignore` could include additional patterns for temporary files.
- README could provide more explicit input/output examples.
- Python scripts had improved documentation - e.g.,  `cfexercises1.py` included docstrings for all functions - good.
- `align_seqs.py` required better error handling for invalid inputs.
 - You could have formatted the output of certain scripts to be  more neat / organised / informative (compare with my solutions) -- for example `lc1.py` is perfectly functional, but the formatting of the output could have been improved.

## Week  3


- Scripts ran fine - no errors.
- README detailed R-specific dependencies and examples of script use.
- Inline comments could improve code readability.

## Week  4


- Directories were well-maintained, with results generated correctly.
- `CompileLaTeX.sh` required system-specific adjustments for successful execution.
- `Florida.R` was well-organized, implementing permutation testing and visualizations effectively.
- Could have used R's vectorized operation for sampling instead of loop.
- Could add more inline comments explaining each analytical step.
- The LaTeX report was concise, with clear explanations and visualization. Including a discussion of the significance of the observed correlation would have improved the scientific narrative.
- The Autocorrelation practical code was more efficient, and provided a correct answer to the question. The provided and biological/ecological interpretations in the report could have been stronger; had a somewhat weak conclusion at the end.
- Your Groupwork practicals were all in order, and your group did well in collaborating on it based on the commit/merge/pull history. Check the groupwork feedback pushed to your group repo for more details.   

---

## Git Practices

- Git repo size was about 7.60 MiB - that's reasonable, though there was scope to keep it slimmer with the correct gitignore exclusions 
- Commit frequency and detail improved significantly over the weeks.
- Early messages were vague (e.g., "update script"). Use descriptive messages like "Refactor Florida.R to include xxx.", etc
- Introduce feature branches for isolating major changes and reducing conflicts.

---

## Overall Assessment

Overall, a good job! 

You demonstrated significant growth in programming skills, workflow organization, and documentation. 

Commenting could be improved -- you are currently erring on the side of overly verbose comments at times (including in your readmes), which is nonetheless better than not commenting at all, or too little! This will improve with experience, as you will begin to get a feel of what is ``common-knowledge'' among programmers, and what stylistic idioms are your own and require explanation. In general though, comments should be written to help explain a coding or syntactical decision to a user (or to your future self re-reading the code!) rather than to describe the meaning of a symbol, argument or function (that should be in the function docstring in Python for example).

It was a tough set of weeks, but I hope they have given you a good start towards further training, a quantitative masters dissertation, and ultimately a career in quantitative biology! 


### (Provisional) Mark
*71*