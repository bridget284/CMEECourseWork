# function to take the mean of a sample of a 
doit <- function(x) {
  temp_x <- sample(x, replace = TRUE)
  if(length(unique(temp_x)) > 30) {#only take mean if sample is large
    print(paste("Mean of this sample was:", as.character(mean(temp_x))))
  }
  else{
    stop("Couldn't calculate mean: too few unique values!")
  }
}


#generate population
set.seed(1345)
popn <- rnorm(50)
hist(popn)

# run the doit function 15 times from the population popn
result <- lapply(1:15, function(i) try(doit(popn), FALSE))

result <- vector("list", 15) # Preallocate/Initialize
for(i in 1:15) {
  result[[i]] <- try(doit(popn), FALSE)
}
