years <- 1990:2009
years
years <- 2009:1990
years
seq(1,10,0.5)
myvar<-c("a", "b", "c", "d", "e")
myvar[1]
myvar[4]
myvar[c(1,1,5,5)]
v <- c(0,1,2,3,4)
v[3]
v[1:3]
v[-3]
mat1 <- matrix(1:25,5,5, byrow=TRUE)
mat1
mat1[1,]
mat1[,1]
a <- c(1,5)+2
a
paste("Year is:", 1990:2000) 
mydata <- read.csv("data/trees.csv")
ls(pattern = "my*")
class(mydata)
head(mydata)
str(mydata)
write.csv(mydata, "results/MyData.csv")
