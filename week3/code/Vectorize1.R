# create matrix
M <- matrix(runif(1000000),1000,1000)

# function to sum all the elements of matrix m, and return the total
SumAllElements <- function(M) {
  Dimensions <- dim(M)
  Tot <- 0
  for (i in 1:Dimensions[1]){
    for (j in 1:Dimensions[2]){
      Tot = Tot + M[i,j]
    }
  }
  return(Tot)
}

# print time taken to use function SumAllElements and time taken using the inbuilt vectorized function
print("Using loops, the time taken is:")
print(system.time(SumAllElements(M)))
print("Using the inbuilt vectorized function, the time taken is:")
print(system.time(sum(M)))
