SomeOperation<-function(v){ #if the sum of all components of matrix is 
  #positive, the components are multiplied by 100, if not nothingn happens
  if (sum(v)>0){
    return(v*100)
  } else{
      return(v)
  }
}

M <- matrix(rnorm(100),10,10)
print(apply(M,1,SomeOperation))
