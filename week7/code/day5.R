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



pheno$Date<-as.Date(pheno$Date, format = "%d/%m/%Y")
silweather$Date<-as.Date(silweather$Date, format = "%d/%m/%Y")

names(silweather)[7]<-"AirMin"

require(dplyr)
silweather <- silweather %>% filter(AirMin >= -20)



# Function to calculate weekly average of Air_Temp_Min...Deg.C...Min for each date in pheno
get_weekly_avg <- function(date) {
  # Filter silweather data for the week before the given date
  week_data <- silweather %>%
    filter(Date >= (date - 7) & Date < date)
  
  # Calculate the mean of Air_Temp_Min...Deg.C...Min if there are rows; otherwise, return NA
  if (nrow(week_data) > 0) {
    mean(week_data$AirMin, na.rm = TRUE)
  } else {
    NA  # Return NA if no data is available for the week
  }
}

# Apply the function to each date in pheno to get weekly averages
pheno$AvgAirMin_LastWeek <- sapply(pheno$Date, get_weekly_avg)









data<-pheno




# remove <> from scores and turn them into numbers
data$Score <- gsub("[<>]", "", data$Score)
data$Score<- as.numeric(data$Score)
# remove outliers and nas
data <- data[data$Score <= 6, ]
data <- data[is.na(data$Score)==F, ]




data$remarks=NULL
colSums(is.na(data))
data<-na.omit(data)



data2<-data





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
  if (data2$Score[i] %in% c("1","2","3")){
    data2$Score[i] = 0
  }
}
for (i in 1:nrow(data2)) {
  if (data2$Score[i] %in% c("4", "5", "6")){
    data2$Score[i] = 1
  }
}


# Remove rows where month is "03"
table(data2$week)
data2 <- data2 %>% filter(week != "3")
data2 <- data2 %>% filter(week != "4")
data2 <- data2 %>% filter(week != "5")
data2 <- data2 %>% filter(week != "12")
data2 <- data2 %>% filter(week != "13")
data2 <- data2 %>% filter(week != "14")
data2 <- data2 %>% filter(week != "15")
data2 <- data2 %>% filter(week != "16")

data2$week <- data2$week - 5


m1<-glm(Score~AvgAirMin_LastWeek+factor(week), data=data2, family="binomial")
summary(m1)
anova(m1,test="Chisq")






AirMin_values <- seq(from = -3.1, to = 10.1, length = 100)

# Define the month levels as a factor
week_levels <- factor(c("1", "2", "3", "4", "5", "6" ))

# Create a new_data dataframe with all combinations of AirMin and month
new_data <- expand.grid(AvgAirMin_LastWeek = AirMin_values, week = week_levels)


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

data2$week<-factor(data2$week)
new_data$week<-factor(new_data$week)
require(ggplot2)
ggplot(new_data, aes(x = AvgAirMin_LastWeek, y = pred_prob, color = week, fill = week, group = week)) +
  geom_line(show.legend = TRUE,  size = 2) +  # Use different line types for each month
  geom_point(data2, mapping = aes(x=AvgAirMin_LastWeek, y=Score), col="black", size=1, show.legend = FALSE)+
  geom_ribbon(aes(ymin = lowerCI_prob, ymax = upperCI_prob), alpha = 0.1, show.legend = FALSE) +
  labs(y = "Probability of High Budburst Development", x = "Average Minimum Air Temperature") +
  theme_classic()
