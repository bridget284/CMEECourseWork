NoPreallocFun <- function(x){
  a<-vector()
  for (i in 1:x) {
    a <- c(a,i)
  }
}
print(system.time(NoPreallocFun(1000)))



PreallocFun <- function(x){
  a<-rep(NA,x)
  for(i in 1:x){
    a[i] <- i
  }
}
print(system.time(PreallocFun(1000)))
