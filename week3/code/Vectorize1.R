M <- matrix(runif(1000000),1000,1000)

SumAllElements <- function(M) {
  Dimentions <- dim(M)
  Tot <- 0
  for (i in 1:Dimentions[1]){
    for (j in 1:Dimentions[2]){
      Tot = Tot + M[i,j]
    }
  }
  return(Tot)
}

print("Using loops, the time taken is:")
print(system.time(SumAllElements(M)))
print("Using the inbuilt vectorized function, the time taken is:")
print(system.time(sum(M)))