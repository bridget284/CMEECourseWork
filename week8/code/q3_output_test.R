# output of q3 test

rm(list=ls()) # good practice

# create list 
results<-list()

# read in data, into a list of 15000 simulations of 121 values
for (i in 1:100) {
  filename <- paste0("/home/bridget-smith/Documents/CMEECourseWork/week8/data/output_", i, ".rda")
  load(filename)
  results<-append(results, population)
}


# finds the number of simulations that go extinct
a = 0
for (i in 1:15000) {
  if (results[[i]][121] == 0) {
    a = a + 1
  }
}



