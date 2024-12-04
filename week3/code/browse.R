# runs a simulation of exponential growth
# returns a vector of length generations
Exponential <- function(N0=1,r=1,generations=10){
  
  N<-rep(NA, generations) #creates a vector
  
  N[1]<-N0 # initial population
  for (t in 2:generations){
    N[t] <- N[t-1]*exp(r) # exponential growth, for loop runs through each generation population change
  }
  return(N)
}

# plot results
plot(Exponential(), type="l", main="Exponential growth", xlab="Generation", ylab="Population")

