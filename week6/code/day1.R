# requirements
require(ggplot2)
require(MASS)
require(ggpubr)



# HAND OUT 1
# data
fish<-read.csv("../data/fisheries.csv", stringsAsFactors = T)
str(fish)

# visualize data
ggplot(fish, aes(x=MeanDepth, y=TotAbund))+
  geom_point()+
  labs(x="Mean Depth (km)", y="Total Abundance")+
  theme_classic()
  
# fitting the model
model1 <- glm(TotAbund~MeanDepth, data=fish, family = "poisson")
summary(model1)
par(mfrow=c(2,2))
plot(model1)
sum(cooks.distance(model1)>1)
# model is overdispersed

# visualize data
scatterplot<-ggplot(fish, aes(x=MeanDepth, y=TotAbund,
                              color=factor(Period)))+
  geom_point()+
  labs(x="Mean Depth (km)", y="Total Abundance")+
  theme_classic()+
  scale_color_discrete(name="Period", labels=c("1979-1989", "1997-2002"))
boxplot<-ggplot(fish, aes(x=factor(Period, labels=c("1979-1989", "1997-2002")), y=TotAbund))+
  geom_boxplot()+
  theme_classic()+
  labs(x="Period", y="Total Abundance")
ggarrange(scatterplot, boxplot, labels=c("A","B"), ncol=1, nrow=2)

# adding time period as a fixed factor
fish$Period<-factor(fish$Period)
model2<-glm(TotAbund~MeanDepth*Period, data=fish, family="poisson")
summary(model2)
plot(model2)
anova(model2, test="Chisq")
# model is still overdispersed

# fitting a negative binomial
model3<-glm.nb(TotAbund~MeanDepth*Period, data=fish)
summary(model3)
anova(model3, test="Chisq")
# no significant difference in slopes, but sig diff in intercept

# take out interaction 
model4<-glm.nb(TotAbund~MeanDepth+Period, data=fish)
summary(model4)
anova(model4, test="Chisq")
plot(model4)

# plotting the negative binomial model
range(fish$MeanDepth)
period1 <- data.frame(MeanDepth=seq(from=0.804, to=4.865, length=100), Period="1")
period2 <- data.frame(MeanDepth=seq(from=0.804, to=4.865, length=100), Period="2")
period1_predictions<- predict(model4, newdata = period1, type = "link", se.fit = TRUE) # the type="link" here predicted the fit and se on the log-linear scale. 
period2_predictions<- predict(model4, newdata = period2, type = "link", se.fit = TRUE)
period1$pred<- period1_predictions$fit
period1$se<- period1_predictions$se.fit
period1$upperCI<- period1$pred+(period1$se*1.96)
period1$lowerCI<- period1$pred-(period1$se*1.96)
period2$pred<- period2_predictions$fit
period2$se<- period2_predictions$se.fit
period2$upperCI<- period2$pred+(period2$se*1.96)
period2$lowerCI<- period2$pred-(period2$se*1.96)
complete<- rbind(period1, period2)

# Making the Plot 
ggplot(complete, aes(x=MeanDepth, y=exp(pred)))+ 
  geom_line(aes(color=factor(Period)))+
  geom_ribbon(aes(ymin=exp(lowerCI), ymax=exp(upperCI), fill=factor(Period), alpha=0.3), show.legend = FALSE)+ 
  geom_point(fish, mapping = aes(x=MeanDepth, y=TotAbund, color=factor(Period)))+
  labs(y="Total Abundance", x="Mean Depth (km)")+
  theme_classic()+
  scale_color_discrete(name="Period", labels=c("1979-1989", "1997-2002"))



# HAND OUT 2
# requirements
require(ggplot2)
require(ggpubr)

# read data
worker<-read.csv("../data/workerbees.csv", stringsAsFactors = T)
str(worker)

# visualize data
scatterplot<-ggplot(worker, aes(x=CellSize, y=Parasites))+geom_point()+
  labs(x="Cell Size (cm)",y="Probability of Parasite")+
  theme_classic()
boxplot<-ggplot(worker, aes(x=factor(Parasites), y=CellSize))+
  geom_boxplot()+theme_classic()+
  labs(x="Presence/Absence of Parasites", y="Cell Size (cm)")
ggarrange(scatterplot, boxplot, labels=c("A","B"),ncol=1,nrow=2)

# creating the model
model1<-glm(Parasites~CellSize, data=worker, family="binomial")
summary(model1)

# plotting the model
range<-range(worker$CellSize)
new_data<-data.frame(CellSize=seq(from=range[1], to=range[2], length=100))
predictions<-predict(model1, newdata = new_data, type="link", se.fit=TRUE)
new_data$pred<-predictions$fit
new_data$se<-predictions$se.fit
new_data$upperCI<-new_data$pred+(new_data$se*1.96)
new_data$lowerCI<-new_data$pred-(new_data$se*1.96)

# making the plot
ggplot(new_data, aes(x=CellSize, y=plogis(pred)))+ 
  geom_line(col="black")+
  geom_point(worker, mapping = aes(x=CellSize, y=Parasites), col="blue")+
  geom_ribbon(aes(ymin=plogis(lowerCI), ymax=plogis(upperCI), alpha=0.2), show.legend = FALSE)+ 
  labs(y="Probability of Infection", x="Cell Size (cm)")+
  theme_classic()
