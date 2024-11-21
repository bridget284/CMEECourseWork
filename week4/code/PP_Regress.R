rm(list=ls())

# read in data
data<-read.csv("../data/EcolArchives-E089-51-D1.csv")
head(data)
colSums(is.na(data))

for (i in 1:length(data$Prey.mass.unit)){
  if (data$Prey.mass.unit[i] == "mg"){
    data$Prey.mass.unit[i] <- "g"
    data$Prey.mass[i] <- data$Prey.mass[i] / 1000
  }
}




model <- lm(Predator.mass ~ Prey.mass, 
            data = data, 
            subset = (Predator.lifestage == "adult" & Type.of.feeding.interaction == "predacious"))
summary(model)



ggplot(data, aes(x = Prey.mass, y = Predator.mass, color = Predator.lifestage)) +
  geom_point(shape=3, size=2) +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(method = "lm",  fullrange = TRUE) +
  facet_grid(Type.of.feeding.interaction~.)+
  theme_bw()+
  theme(legend.position = "bottom") +
  labs(x="Prey mass in grams", y="Predator mass in grams")




