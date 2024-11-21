rm(list=ls())

# read in data
data<-read.delim("../data/ObserverRepeatability.txt", header=T)
str(data)

# visualize data
hist(data$Tarsus)
hist(data$BillWidth)

# remove outliers
data2<-subset(data, data$Tarsus<=40)
#data2<-subset(data2, data2$Tarsus>=10)
hist(data2$Tarsus)
summary(data2$Tarsus)
summary(data2$BillWidth)
var(data2$BillWidth)

# packages
require(lme4)
require(lmtest)

# make model
mT1<-lmer(Tarsus~1+(1|StudentID), data=data2)
mT2<-lmer(Tarsus~1+(1|StudentID)+(1|GroupN), data=data2)
lrtest(mT1,mT2) # likelyhood ratio test

summary(mT2)


# results section
"We tested whether student identiy and group identity explained variance in a dataset of
360 measurements of a stuffed sparrow's tarsus, although three observations were removed from 
the model as they are outliers. The likelihood ratio test revealed that
group identity did explain statistically significant amounts of variance (chi square =
12.51, df = 4, p=0.0004). The final model used was then the model that included group identity. Accounting for student
identity, the final model revealed that the measurement of tarsus was on average 18.0mm
(0.40SE, Table 1). Student identity explained 89%* of all variance in the dataset (Table 1).
* the variances are 7.21 and 0.89, 7.21/(7.21+0.89)=0.89"