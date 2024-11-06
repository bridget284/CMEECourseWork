# set environment and read in data
rm(list=ls())
daphnia<-read.table("../data/daphnia.txt", header=TRUE)

# ho11

# look through data
summary(daphnia)
head(daphnia)
str(daphnia)

# outliers
par(mfrow=c(1,2))
plot(Growth.rate ~ as.factor(Detergent), data=daphnia)
plot(Growth.rate ~ as.factor(Daphnia), data=daphnia)

# homogeneity of variances
require(dplyr)
daphnia %>% # find variance of growth rate for each detergent
  group_by(Detergent) %>%
  summarise(variance=var(Growth.rate))

daphnia %>% # find variance of growth rate for each clone
  group_by(Daphnia) %>% 
  summarise(variance=var(Growth.rate))

# data exploration
dev.off()
hist(daphnia$Growth.rate)

# model
seFun <- function(x) {
  sqrt(var(x)/length(x))
}
detergentMean<-with(daphnia,tapply(Growth.rate, INDEX = Detergent, FUN=mean))
detergentSEM<-with(daphnia,tapply(Growth.rate, INDEX = Detergent, FUN=seFun))
cloneMean<-with(daphnia,tapply(Growth.rate, INDEX = Daphnia, FUN=mean))
cloneSEM<-with(daphnia,tapply(Growth.rate, INDEX = Daphnia, FUN=seFun))
clone.Mean<-as.vector(cloneMean)
par(mfrow=c(2,1),mar=c(4,4,1,1))
barMinds<-barplot(detergentMean,xlab="Detergent type", ylab="Population growth rate", ylim=c(0,5))
arrows(barMinds, detergentMean - detergentSEM, barMinds, detergentMean + detergentSEM, code=3, angle=90)
barMinds<-barplot(cloneMean,xlab="Daphnia clone", ylab="Population growth rate", ylim=c(0,5))
arrows(barMinds, cloneMean - cloneSEM, barMinds, cloneMean + cloneSEM, code=3, angle=90)


# multiple linear model
daphniaModel <- lm(Growth.rate~Detergent + Daphnia, data=daphnia)
summary(daphniaModel)
boxplot(Growth.rate~Detergent + Daphnia, data=daphnia)
# find the relative means
detergentMean - detergentMean[1]
cloneMean - clone.Mean[1]
# anova
daphniaANOVAModel <- aov(Growth.rate ~ Detergent + Daphnia, data=daphnia)
summary(daphniaANOVAModel)
# tukey test
daphniaModelHSD<-TukeyHSD(daphniaANOVAModel)
daphniaModelHSD
par(mfrow=c(2,1),mar=c(4,4,4,4))
plot(daphniaModelHSD)

par(mfrow=c(2,2))
plot(daphniaModel)








# timber example
timber<-read.delim("../data/timber.txt")
summary(timber)
str(timber)
head(timber)

# outliers
par(mfrow = c(2,2))
boxplot(timber$volume)
boxplot(timber$girth)
boxplot(timber$height)

# homogeneity of variances
var(timber$volume)
var(timber$girth)
var(timber$height)
nvol<-as.data.frame(subset(timber, timber$volume!="NA"))
nvol$z.girth<-scale(timber$girth)
nvol$z.height<-scale(timber$height)
var(nvol$z.girth)
plot(nvol)

# check distribution
par(mfrow = c(2,2))
hist(nvol$volume)
hist(nvol$girth)
hist(nvol$height)
pairs(timber)
cor(timber)

# check collinearity
summary(lm(girth~height, data=timber))
VIF<-1/(1-0.27) # 1/(1-R^2)
VIF

cor(nvol)
timberModel<-lm(volume~girth+height, data=timber)
anova(timberModel)
summary(timberModel)
# as r^2 is 0.95, 95% of the data can be explained using
# volume = intercept + girthEstimate*girth + heightEstimate*height
# model only valid within the ranges of the data provided
plot(timberModel)







# ho12timberModel# ho12
# set environment and read in data
rm(list=ls())
d<-read.table("../data/SparrowSize.txt", header=TRUE)

# histogram of wing length
wing<-subset(d, d$Wing!="NA")
summary(wing$Wing)
hist(wing$Wing)
# linear model of wing length by sex
wing_model<-lm(Wing~Sex.1,data=wing)
summary(wing_model)
boxplot(wing$Wing~wing$Sex.1, ylab="Wing length (mm)")
