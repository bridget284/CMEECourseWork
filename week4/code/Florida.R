rm(list=ls())

# read in data
load("../data/KeyWestAnnualMeanTemperature.RData")

# explore data
head(ats)
colSums(is.na(ats))

# find correlation coefficient for the data
cor_1 <- cor(ats$Year,ats$Temp)

# find correlation coefficients for shuffled data
repeats <- 100000
cors <- rep(0,repeats)
count = 0
for (i in 1:repeats) {
  set.seed(i)
  data<-sample(ats$Temp)
  cors[i] <-cor(ats$Year, data)
  if (cors[i]>cor_1){
    count <- count + 1
  }
}
fraction <- count/repeats
require(ggplot2)
mean <- mean(cors)
cors_df <- data.frame(Correlation = cors)

library(ggplot2)

# Histogram of Correlation Coefficients
plot<-ggplot(cors_df, aes(x = Correlation)) +
  geom_histogram(bins = 30, fill = "purple", color = "black") +
  labs(x = "Correlation Coefficient",
       y = "Frequency") +
  theme_bw()





