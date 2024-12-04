SomeOperation<-function(v){ #if the sum of all components of matrix is 
  # positive, the components are multiplied by 100, if not nothing happens
  if (sum(v)>0){ # check if sum of entries in matrix m is less than 0
    return(v*100) # multiply entries in the matrix by 100, and return the new matrix
  } else{
      return(v)
  }
}

# create matrix m, run the function SomeOperation on m, print m
M <- matrix(rnorm(100),10,10)
print(apply(M,1,SomeOperation))
