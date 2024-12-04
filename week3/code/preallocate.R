# this script contains two functions to print a vector from 1 to x
# one function preallocates the size of the vector, one doesnt

# function without preallocation
NoPreallocFun <- function(x){
  a<-vector()
  for (i in 1:x) {
    a <- c(a,i)
  }
}
print(system.time(NoPreallocFun(1000))) # print the time taken for this function to run


# function with preallocation
PreallocFun <- function(x){
  a<-rep(NA,x) # preallocates the vector 
  for(i in 1:x){                                                  
    a[i] <- i
  }
}
print(system.time(PreallocFun(1000))) # print the time taken for this function to run
