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






num_species <- length(unique(trees$species))
num_species

species_counts <- table(trees$species)
species_counts

hist(girth$Girth_cm)
#boxplot(girth$HeightGirth_cm)
table(girth$Estimated)
class(girth$Girth_cm)

boxplot(girth$Girth_cm ~ girth$TreeForm)









# create new data frame
data<-merge(trees, pheno, by="TreeID")
girth$Date<-NULL
data<-merge(data, girth, by="TreeID")

# line up date in silweather to match with data, then merge
for (i in 1:nrow(silweather)){
  silweather$TIMESTAMP[i] <- gsub(pattern = " 9:00", x=silweather$TIMESTAMP[i], replacement="")
}
silweather$Date<-silweather$TIMESTAMP
silweather$TIMESTAMP<-NULL
data<-merge(data, silweather, by="Date")


# remove columns
data$remarks.x <- NULL
data$remarks.y <- NULL
data$HeightGirth_cm <- NULL
data$Stems <- NULL
data$Estimated <- NULL
data$VisitID<-NULL
data$Record<-NULL

# dates go from 02/04/2007 to 17/05/2023 months 03-06
data$Date<-as.Date(data$Date, format = "%d/%m/%Y")
data$week <- NA
data$month <- NA
#months_name <- month.name
#months_num <- sprintf("%02d", 1:12)



for (i in 1:nrow(data)){
  data$month[i] <- format(data$Date[i], "%m")
}


for (i in 1:nrow(data)) {
  day <- as.integer(format(data$Date[i], "%d"))
  data$week[i] <- ifelse(day <= 7, 1,
                         ifelse(day <= 15, 2,
                                ifelse(day <= 23, 3, 4)))
}

data$Score <- gsub("[<>]", "", data$Score)
data$Score<- as.numeric(data$Score)
data <- data[data$Score <= 6, ]
data <- data[is.na(data$Score)==F, ]
data$northing<- as.numeric(data$northing)
data$easting<- as.numeric(data$easting)
data$latitude<- as.numeric(data$latitude)
data$longitude<- as.numeric(data$longitude)



# make data frames for each month
data_march <- data[format(data$Date, "%m")=="03", ]
data_april <- data[format(data$Date, "%m")=="04", ]
data_may <- data[format(data$Date, "%m")=="05", ]
data_june <- data[format(data$Date, "%m")=="06", ]
#data_march_1 <- data[format(data_march$Date, "%d") %in% sprintf("%02d", 1:7), ]
#data_march_2 <- data[format(data_march$Date, "%d") %in% sprintf("%02d", 8:15), ]
#data_march_3 <- data[format(data_march$Date, "%d") %in% sprintf("%02d", 16:23), ]
#data_april_4 <- data[format(data_april$Date, "%d") %in% sprintf("%02d", 24:31), ]

# remove <> from scores and turn them into numbers
data_march$Score <- gsub("[<>]", "", data_march$Score)
data_march$Score<- as.numeric(data_march$Score)

data_april$Score <- gsub("[<>]", "", data_april$Score)
data_april$Score<- as.numeric(data_april$Score)
data_april <- data_april[data_april$Score <= 6, ]
data_april <- data_april[is.na(data_april$Score)==F, ]

data_may$Score <- gsub("[<>]", "", data_may$Score)
data_may$Score<- as.numeric(data_may$Score)
data_may <- data_may[data_may$Score <= 6, ]
data_may <- data_may[is.na(data_may$Score)==F, ]

data_june$Score <- gsub("[<>]", "", data_june$Score)
data_june$Score<- as.numeric(data_june$Score)

# boxplot the scores
par(mfrow=c(2,2))
boxplot(data_march$Score)
boxplot(data_april$Score)
boxplot(data_may$Score)
boxplot(data_june$Score)









