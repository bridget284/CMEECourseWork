#read in data
MyDF <- read.csv("data/EcolArchives-E089-51-D1.csv")

#look at dimentions, then use tidyverse to look at summary of data
dim(MyDF) #check the size of the data frame you loaded
require(tidyverse)
glimpse(MyDF)

#change some columns to factors
MyDF$Type.of.feeding.interaction <- as.factor(MyDF$Type.of.feeding.interaction)
MyDF$Location <- as.factor(myDF$Location)
str(MyDF)

#scatter plots
plot(MyDF$Predator.mass, MyDF$Prey.mass)
#use logs, change marker shape
plot(log10(MyDF$Predator.mass), log10(MyDF$Prey.mass), pch=20)
#labels
plot(log10(MyDF$Predator.mass), log10(MyDF$Prey.mass), pch=20, xlab = "Predator mass", ylab = "Prey mass")


#histogram
hist(MyDF$Predator.mass)
#logs, colour
hist(log10(MyDF$Predator.mass), xlab = "Log10(Predator mass)", ylab = "Count",
     col="darkblue", border="purple")
#prey
hist(log10(MyDF$Prey.mass), xlab = "Log10(Prey mass)", ylab = "Count",
     col="darkblue", border="purple")


#subplots
dev.off()
par(mfcol=c(2,1)) #initialize multi-paneled plot
par(mfg = c(1,1)) # specify which sub-plot to use first 
hist(log10(MyDF$Predator.mass),
     xlab = "log10(Predator Mass (g))", ylab = "Count", col = "lightblue", border = "pink", 
     main = 'Predator') # Add title
par(mfg = c(2,1)) # Second sub-plot
hist(log10(MyDF$Prey.mass), xlab="log10(Prey Mass (g))",ylab="Count", col = "lightgreen", border = "pink", main = 'prey')

#overlapped histogram
hist(log10(MyDF$Predator.mass), # Predator histogram
     xlab="log10(Body Mass (g))", ylab="Count", 
     col = rgb(1, 0, 0, 0.5), # Note 'rgb', fourth value is transparency
     main = "Predator-prey size Overlap") 
hist(log10(MyDF$Prey.mass), col = rgb(0, 0, 1, 0.5), add = T) # Plot prey
legend('topleft',c('Predators','Prey'),   # Add legend
       fill=c(rgb(1, 0, 0, 0.5), rgb(0, 0, 1, 0.5))) # Define legend colors


#boxplots
boxplot(log10(MyDF$Predator.mass), xlab = "Location", ylab = "log10(Predator Mass)", main = "Predator mass")

boxplot(log(MyDF$Predator.mass) ~ MyDF$Location, # tilde subdivides the data, plots by (the factor) location
        xlab = "Location", ylab = "Predator Mass",
        main = "Predator mass by location")

boxplot(log(MyDF$Predator.mass) ~ MyDF$Type.of.feeding.interaction, #plots by feeding interaction type
        xlab = "Location", ylab = "Predator Mass",
        main = "Predator mass by feeding interaction type")


#combine scatter and box plot
par(fig=c(0,0.8,0,0.8)) # specify figure size as proportion
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass), xlab = "Predator Mass (g)", ylab = "Prey Mass (g)") # Add labels
par(fig=c(0,0.8,0.4,1), new=TRUE)
boxplot(log(MyDF$Predator.mass), horizontal=TRUE, axes=FALSE)
par(fig=c(0.55,1,0,0.8),new=TRUE)
boxplot(log(MyDF$Prey.mass), axes=FALSE)
mtext("Fancy Predator-prey scatterplot", side=3, outer=TRUE, line=-3)


#saving graphs
pdf("../results/Pred_Prey_Overlay.pdf", # Open blank pdf page using a relative path
    11.7, 8.3) # These numbers are page dimensions in inches
hist(log(MyDF$Predator.mass), # Plot predator histogram (note 'rgb')
     xlab="Body Mass (g)", ylab="Count", col = rgb(1, 0, 0, 0.5), main = "Predator-Prey Size Overlap") 
hist(log(MyDF$Prey.mass), # Plot prey weights
     col = rgb(0, 0, 1, 0.5), 
     add = T)  # Add to same plot = TRUE
legend('topleft',c('Predators','Prey'), # Add legend
       fill=c(rgb(1, 0, 0, 0.5), rgb(0, 0, 1, 0.5))) 
graphics.off(); #you can also use dev.off() 