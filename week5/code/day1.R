2*2+1
myNumericVector <- c(1.3,2.5,1.9,3.4,5.6,1.4,3.1,2.9)
str(myNumericVector)

install.packages("lme4")
require(lme4)
d<-read.table("../data/SparrowSize.txt", header=TRUE)
str(d)
summary(d)


require(dplyr)
BirdIDCount <- d %>% 
  count(BirdID, sort = TRUE)

# Count occurrences of each unique count in BirdIDCount
BirdIDCountSummary <- BirdIDCount %>% 
  count(n)










# ho2
length(d$Tarsus) #tarsus is a bone
hist(d$Tarsus)
mean(d$Tarsus, na.rm = TRUE) #remove NA values
median(d$Tarsus, na.rm = TRUE)
mode(d$Tarsus)


#plot
par(mfrow = c(2,2))
hist(d$Tarsus, breaks = 3, col="purple")
hist(d$Tarsus, breaks = 10, col="purple")
hist(d$Tarsus, breaks = 30, col="purple")
hist(d$Tarsus, breaks = 100, col="purple")

#finding the mode
d$Tarsus.rounded<-round(d$Tarsus, digits=1)
head(d$Tarsus.rounded)
d2<-subset(d, d$Tarsus!="NA")
length(d$Tarsus)-length(d2$Tarsus)

TarsusTally <- d2%>% count(Tarsus.rounded, sort = TRUE)
mode <- TarsusTally[[1]][1]



#range, variance, sd, d2 has no NA
range(d$Tarsus,na.rm=TRUE)
range(d2$Tarsus, na.rm = TRUE)
var(d$Tarsus, na.rm = TRUE)
var(d2$Tarsus, na.rm = TRUE)

# z transformation, divide each deviation from the mean (for each value) by 
# overall sd: z(i) = [y(i)-y_bar] / sd
# this gives a data set with sd=var=1, mean=0
zTarsus <- (d2$Tarsus - mean(d2$Tarsus))/sd(d2$Tarsus)
hist(zTarsus)
# or use the r function scale()



#some plots
boxplot(d$Tarsus~d$Sex.1, col = c("red", "blue"), ylab="Tarsus length (mm)")


par(mfrow = c(1, 2))
hist(zTarsus, breaks = 100)
abline(v = qnorm(c(0.25, 0.5, 0.75)), lwd = 2)
abline(v = qnorm(c(0.025, 0.975)), lwd = 2, lty = "dashed")
plot(density(znormal))
abline(v = qnorm(c(0.25, 0.5, 0.75)), col = "gray")
abline(v = qnorm(c(0.025, 0.975)), lty = "dotted", col = "black")
abline(h = 0, lwd = 3, col = "blue")
text(2, 0.3, "1.96", col = "red", adj = 0)
text(-2, 0.3, "-1.96", col = "red", adj = 1)





## lecture 4 - standard error
mean <- mean(d2$Tarsus)
n <- length(d2$Tarsus)
var <- var(d2$Tarsus)
stderr <- sqrt(var/n)
ci <- 1.96*stderr
stderr <- round(stderr, digits = 4)
ci <- round(ci, digits=4)
mean <- round(mean, digits = 4)
print(paste("The 95 confidence interval is:", mean, "+-", ci))

#2001 only
d3<-subset(d2, d2$Year=="2001")
mean_01 <- mean(d3$Tarsus)
n_01 <- length(d3$Tarsus)
var_01 <- var(d3$Tarsus)
stderr_01 <- sqrt(var_01/n_01)
ci_01 <- 1.96*stderr_01
stderr_01 <- round(stderr_01, digits = 4)
ci_01 <- round(ci_01, digits=4)
mean_01 <- round(mean_01, digits = 4)
print(paste("The 95 confidence interval is:", mean_01, "+-", ci_01))




