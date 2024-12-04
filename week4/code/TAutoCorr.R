rm(list=ls())

# read in data
load("../data/KeyWestAnnualMeanTemperature.RData")

# explore data
head(ats)
colSums(is.na(ats))

# create vectors of sucessive temperatures
years_1 <- ats$Temp
years_1 <- years_1[-length(years_1)] # years_1 is all temperatures excluding first year
years_2 <- ats$Temp
years_2 <- years_2[-1]
cor_1 <- cor(years_1, years_2) # years_2 is all temperatures excluding last year

# find correlation coefficients for shuffled data
# set up variables 
simulations <- 10000
cors <- rep(0,simulations) # to store correlation values
count = 0 # count of correlation values larger than non-shuffelled correlation

for (i in 1:simulations) {
  set.seed(i)
  data<-sample(years_1)
  cors[i] <-cor(years_2, data)
  if (cors[i]>cor_1){
    count <- count + 1
  }
}
fraction <- count / simulations
mean(cors)
