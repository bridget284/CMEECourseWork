# set environment and read in data
rm(list=ls())
girth<-read.csv("../data/girth.csv")
#head(girth)
pheno<-read.csv("../data/phenology.csv")
#head(pheno)
trees<-read.csv("../data/trees.csv")
#head(trees)
silweather<-read.csv("../data/SilwoodWeatherDaily.csv")
#head(silweather)




# line up date in silweather to match with data, then merge
for (i in 1:nrow(silweather)){
  silweather$TIMESTAMP[i] <- gsub(pattern = " 9:00", x=silweather$TIMESTAMP[i], replacement="")
}
silweather$Date<-silweather$TIMESTAMP
silweather$TIMESTAMP<-NULL
data<-merge(pheno, silweather, by="Date")



# remove <> from scores and turn them into numbers
data$Score <- gsub("[<>]", "", data$Score)
data$Score<- as.numeric(data$Score)
# remove outliers and nas
data <- data[data$Score <= 6, ]
data <- data[is.na(data$Score)==F, ]






# check out data
#hist(data$Air_Temp..Deg.C...Smp.)
#hist(data$Grass_Temp..Deg.C...Smp.)
#hist(data$Soil_Temp_2in...Deg.C...Smp.)
#hist(data$Soil_Temp_4in...Deg.C...Smp.)
#hist(data$Air_Temp_Max...Deg.C...Max.)
#hist(data$Air_Temp_Min...Deg.C...Min.)
#hist(data$Grass_Temp_Max..Deg.C...Max.)
#hist(data$Grass_Temp_Min..Deg.C...Min.)
#hist(data$Rain_mm_Tot...mm...Tot.)


data$remarks=NULL
colSums(is.na(data))
data<-na.omit(data)











data2<-data[c(1,4,7,10,11,13,14)]

# renaming columns
names(data2)[3]<-"GrassTemp"
names(data2)[4]<-"AirMax"
names(data2)[5]<-"AirMin"
names(data2)[6]<-"GrassMin"
names(data2)[7]<-"Rain"

# create column month for which month each data point is in
# they are all between 04 and 06
data2$Date<-as.Date(data2$Date, format = "%d/%m/%Y")
data2$month <- NA
for (i in 1:nrow(data2)){
  data2$month[i] <- format(data2$Date[i], "%m")
}





data2$week<-NA
for (i in 1:nrow(data2)) {
  day <- as.integer(format(data2$Date[i], "%d"))
  if (data2$month[i]=="03"){
    data2$week[i] <- ifelse(day <= 7, 1,
                            ifelse(day <= 15, 2,
                                   ifelse(day <= 23, 3, 4)))
  }
  if (data2$month[i]=="04"){
    data2$week[i] <- ifelse(day <= 7, 5,
                            ifelse(day <= 15, 6,
                                   ifelse(day <= 23, 7, 8)))
  }
  if (data2$month[i]=="05"){
    data2$week[i] <- ifelse(day <= 7, 9,
                            ifelse(day <= 15, 10,
                                   ifelse(day <= 23, 11, 12)))
  }
  if (data2$month[i]=="06"){
    data2$week[i] <- ifelse(day <= 7, 13,
                            ifelse(day <= 15, 14,
                                   ifelse(day <= 23, 15, 16)))
  }
}



# change scores to be binary
for (i in 1:nrow(data2)) {
  if (data2$Score[i] %in% c("1","2")){
    data2$Score[i] = 0
  }
}
for (i in 1:nrow(data2)) {
  if (data2$Score[i] %in% c("3", "4", "5", "6")){
    data2$Score[i] = 1
  }
}

# Remove rows where month is "03"
require(dplyr)
data2 <- data2 %>% filter(month != "03")

# plots
require(ggplot2)
require(ggpubr)
scatterplot<-ggplot(data2, aes(x=AirMin, y=Score))+
  geom_point()
boxplot<-ggplot(data2, aes(x=factor(Score),y=AirMin))+
  geom_boxplot()
ggarrange(scatterplot, boxplot, labels=c("A","B"), ncol=1, nrow=2)

# Convert 'Score' to a logical binary variable
#data2$Score <- as.logical(data2$Score)
# Convert 'Score' to a factor with levels "0" and "1"
#data2$Score <- factor(data2$Score, levels = c(0, 1), labels = c(TRUE, FALSE))

m1<-glm(Score~AirMin+factor(month), data=data2, family="binomial")
summary(m1)
anova(m1,test="Chisq")




# Define the range for AirMin
AirMin_values <- seq(from = -5.2, to = 16.3, length = 100)

# Define the month levels as a factor
month_levels <- factor(c("04", "05", "06"))

# Create a new_data dataframe with all combinations of AirMin and month
new_data <- expand.grid(AirMin = AirMin_values, month = month_levels)

# Load dplyr if not already loaded
library(dplyr)




# View the new_data to verify
head(new_data)

# Generate predictions on the logit scale with standard errors
predictions <- predict(m1, newdata = new_data, type = "link", se.fit = TRUE)

# Store predictions and confidence intervals in new_data
new_data$pred <- predictions$fit
new_data$se <- predictions$se.fit
new_data$upperCI <- new_data$pred + (1.96 * new_data$se)
new_data$lowerCI <- new_data$pred - (1.96 * new_data$se)

# Optionally, convert to the probability scale using plogis
new_data$pred_prob <- plogis(new_data$pred)
new_data$upperCI_prob <- plogis(new_data$upperCI)
new_data$lowerCI_prob <- plogis(new_data$lowerCI)

ggplot(new_data, aes(x = AirMin, y = pred_prob, color = month, fill = month, group = month)) +
  geom_line(show.legend = TRUE, size = 0.8) +  # Use different line types for each month
  geom_point(data2, mapping = aes(x=AirMin, y=Score), col="black", show.legend = FALSE)+
  geom_ribbon(aes(ymin = lowerCI_prob, ymax = upperCI_prob), alpha = 0.1, show.legend = FALSE) +
  labs(y = "Probability of budburst", x = "Minimum air temperature") +
  theme_classic()








