# checks if an integer is even
is.even <- function(n=2) {
  # check for NA input
  if (is.na(n)) {
    return("Input is NA!")
  }
  
  # check for non-numeric input
  if (!is.numeric(n)) {
    return("Input is not a numeric value!")
  }
  
  # even/odd test
  if (n %% 2 ==0) {
    return(paste(n, "is even!"))
  } else {
    return(paste(n, "is odd!"))
  }
}

is.even(6)



# checks if a number is a power of 2
is.power2 <- function(n=2) {
  # check for NA input
  if (is.na(n)) {
    return("Input is NA!")
  }
  
  # check for non-numeric input
  if (!is.numeric(n)) {
    return("Input is not a numeric value!")
  }
  
  # power of 2 test
  if (log2(n) %% 1 ==0) {
    return(paste(n, "is a power of 2!"))
  } else {
  return(paste(n, "is not a power of 2!"))
  }
}

is.power2(4)



# checks if a number is prime
is.prime <- function(n) {
  # check for NA input
  if (is.na(n)) {
    return("Input is NA!")
  }
  
  # check for non-numeric input
  if (!is.numeric(n)) {
    return("Input is not a numeric value!")
  }
  
  # check if input is 0 or 1
  if (n==0) {
    return(paste(n, "is a zero!"))
  } else if (n==1) {
    return(paste(n, "is just a unit!"))
  }
  
  # prime number test
  ints <- 2:(n-1)
  if (all(n%%ints!=0)) {
    return(paste(n, "is a prime!"))
  } else {
    return(paste(n, "is a composite!"))
  }
}

is.prime(3)
