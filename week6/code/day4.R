# linear mixed models
rm(list=ls())

# packages
require(usdm)
require(psych)
require(lmerTest)
require(sjPlot)

# read data
data<-read.csv("../data/parkgrass_ms.csv")
str(data)

# exploring covariates and collinearity
pairs.panels(data[,-c(1,10,11,12,13)]) # uses package psych
vif(data[,-c(1,10,11,12,13)])
vif(data[,-c(1,6,10,11,12,13)])
vif(data[,-c(1,6,10,11,12,13)])