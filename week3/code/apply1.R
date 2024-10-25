## Build a random matrix
M<- matrix(rnorm(100), 10,10)

##Take the mean of each row
RowMeans <- apply(M,1,mean)
print(RowMeans)

# Now the varience
RowVars <- apply(M,1,var)
print(RowVars)

# by column
ColMeans <- apply(M,2,mean)
print(ColMeans)