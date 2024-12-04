# this script demonstrates basic use of if, for and while in R

# assuming a is Boolean, an if loop will print the value of a
a <- TRUE
if (a == TRUE) {
  print ("a is TRUE")
} else {
  print ("a is FALSE")
}


# a for loop is used to print the squares of 1-10, each with a sentence
for (i in 1:10) {
  j <- i*i
  print(paste(i, " squared is", j))
}


# a for loop printing the names of species with a sentence saying what they are
for(species in c("Heliodoxa rubinoides",
                 "Boissonneaua jardini",
                 "Sula nebouxii")){
  print(paste("The species is", species))
}


# a for loop that prints the values in a vector, v1
v1 <- c("a", "bc", "def")
for (i in v1) {
  print(i)
}


# a while loop which prints the square of 1-10, without a sentence
i <- 0
while (i<10){
  i <- i+1
  print(i^2)
}

