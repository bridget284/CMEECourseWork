rm(list=ls())

# read in data
load("../data/KeyWestAnnualMeanTemperature.RData")

# explore data
head(ats)
plot(ats)
colSums(is.na(ats))

# find correlation coefficient for the data
cor_1 <- cor(ats$Year,ats$Temp)

# find correlation coefficients for shuffled data
cors <- rep(0,10000)
count = 0
for (i in 1:10000) {
  set.seed(i)
  data<-sample(ats$Temp)
  cors[i] <-cor(ats$Year, data)
  if (cors[i]>cor_1){
    count <- count + 1
  }
}



