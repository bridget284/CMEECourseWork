# script to print odd numbers between 1 and 10, using the keyword "next"

for (i in 1:10) {
  if ((i %% 2) == 0) {# check if the number is odd
    next # skip to the next iteration of loop when if condition is true
    print(i)
  }
}
