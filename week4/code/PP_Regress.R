rm(list=ls())

# read in data, explore and check for NAs
data<-read.csv("../data/EcolArchives-E089-51-D1.csv")
head(data)
colSums(is.na(data))

# change units so they are consistant
for (i in 1:length(data$Prey.mass.unit)){
  if (data$Prey.mass.unit[i] == "mg"){
    data$Prey.mass.unit[i] <- "g"
    data$Prey.mass[i] <- data$Prey.mass[i] / 1000
  }
}


# create a table of combinations of feeding interaction and predator lifestage which have data
require(dplyr)
summary_table <- data %>%
  select(Type.of.feeding.interaction, Predator.lifestage) %>%  
  distinct() %>%                                               
  arrange(Type.of.feeding.interaction, Predator.lifestage)    
summary_table <- summary_table[-6, ] # data in this row not sufficient to create a linear model



# plot the graph
require(ggplot2)
my_plot <- ggplot(data, aes(x = Prey.mass, y = Predator.mass, color = Predator.lifestage)) +
          geom_point(shape=3, size=2) +
          scale_x_log10() +
          scale_y_log10() +
          geom_smooth(method = "lm",  fullrange = TRUE) +
          facet_grid(Type.of.feeding.interaction~.)+
          theme_bw()+
          theme(legend.position = "bottom") +
          labs(x="Prey mass in grams", y="Predator mass in grams")

# save plot to a pdf file
pdf("../results/PP_Regress.pdf")
print(my_plot)
dev.off()

# create a data frame for the model results
df <- data.frame(
  Column1 = character(),
  Column2 = character(),
  Column3 = double(),
  Column4 = double(),
  Column5 = double(),
  Column6 = double(),
  Column7 = double()
)
colnames(df) <- c("Feeding interaction", "Predator lifestage", "regression slope", 
                  "regression intercept", "R^2", "F-statistic value", "p-value")


# find model results for each lifestage and feeding interaction combination and add to the data frame
for (i in 1:nrow(summary_table)){
    model <- lm(Predator.mass ~ Prey.mass, 
                    data = data, 
                    subset = (Predator.lifestage == summary_table[i,2] & Type.of.feeding.interaction == summary_table[i,1]))
    intercept <- coef(model)[1]
    slope <- coef(model)[2]
    model_summary <- summary(model)
    r_sq <- model_summary$r.squared
    f_stat <- model_summary$fstatistic[1]
    df1 <- model_summary$fstatistic[2]
    df2 <- model_summary$fstatistic[3]
    f_p_value <- pf(f_stat, df1, df2, lower.tail = FALSE)
    
    
    df <- rbind(df, data.frame("Feeding interaction" = summary_table[i,1],
                "Predator lifestage" = summary_table[i,2],
                "regression slope" = slope,
                "regression intercept" = intercept,
                "R^2" = r_sq,
                "F-statistic value" <- f_stat,
                "p-value" = f_p_value))
  }


# export the data frame as a .csv file
write.csv(df, "../results/PP_Regress_Results.csv", row.names = FALSE)






