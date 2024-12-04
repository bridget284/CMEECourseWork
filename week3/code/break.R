# script to increase i by 1 each loop starting at 0, practice use of break command to exit a loop
# initialize i
i <- 0 
  while (i<Inf) {
    if (i == 10) {
      # prevent while loop from running forever
      break
    } else { 
      cat("i equals ", i, " \n")
      # update i
      i <- i+1 
      }
  }
