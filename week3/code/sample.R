###### Functions ######

## A function to take a sample of size n from a population (popn) and 
# return its mean
myexperiment <- function(popn,n){
  pop_sample <- sample(popn,n,replace=FALSE)
  return(mean(pop_sample))
}

## calculate means using a for loop - no preallocation
loopy_sample1 <- function(popn,n,num){
  result1<-vector() # initialize empty vector of size 1; memory allocation grows with each loop so this will be slow
  for(i in 1:num){
    result1 <- c(result1, myexperiment(popn,n))
  }
  return(result1)
}

## To run "num" iterations of the experiment using a FOR loop on a vector with preallocation:
loopy_sample2 <- function(popn, n, num) {
  result2 <- vector(,num) # Preallocate memory, increasing efficiency by avoiding repeated memory allocation
  for(i in 1:num) {
    result2[i] <- myexperiment(popn, n)
  }
  return(result2)
}

## To run "num" iterations of the experiment using a FOR loop on a list with preallocation:
loopy_sample3 <- function(popn, n, num) {
  result3 <- vector("list", num) # Similar efficiency to loopy_sample2 as a list is preallocated
  for(i in 1:num) {
    result3[[i]] <- myexperiment(popn, n)
  }
  return(result3)
}

## To run "num" iterations of the experiment using vectorization with lapply:
lapply_sample <- function(popn, n, num) {
  result4 <- lapply(1:num, function(i) myexperiment(popn, n)) # using lapply is very efficient due to vectorised approach
  return(result4)
}

## To run "num" iterations of the experiment using vectorization with sapply:
sapply_sample <- function(popn, n, num) {
  result5 <- sapply(1:num, function(i) myexperiment(popn, n)) # using sapply is very efficient due to vectorised approach
  return(result5)
}



# set variables, and plot to show the normal distribution
set.seed(12345)
popn<-rnorm(10000)
hist(popn)

n<-100
num<-10000

# find the time taken to use each function to compare efficiency
print("Using loops without preallocation on a vector took:")
print(system.time(loopy_sample1(popn,n,num)))

print("Using loops with preallocation on a vector took:")
print(system.time(loopy_sample2(popn,n,num)))

print("Using loops with preallocation on a list took:")
print(system.time(loopy_sample3(popn,n,num)))

print("Using the vectorized lapply function (on a list) took:")
print(system.time(lapply_sample(popn,n,num)))

print("Using the vectorized sappy function (on a list) took:")
print(system.time(sapply_sample(popn,n,num)))
