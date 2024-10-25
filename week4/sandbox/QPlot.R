######## ggplot2
require(ggplot2)

#quick plotting
qplot(Prey.mass, Predator.mass, data = MyDF)
qplot(log(Prey.mass), log(Predator.mass), data = MyDF)
#use different colours, aspect ratio
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, colour = Type.of.feeding.interaction, asp = 1)
#use diffferent shapes
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, shape = Type.of.feeding.interaction, asp = 1)
# use I to change from from automatic ggplot choices
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, colour = I("red"))
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, shape= I(3))
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, colour = Type.of.feeding.interaction, alpha = I(.5))#semi transparent shapes

#smoother
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, geom = c("point", "smooth"))
#linear regression
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, geom = c("point", "smooth")) + geom_smooth(method = "lm")
#smoother for each interaction type
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, geom = c("point", "smooth"),
      colour = Type.of.feeding.interaction) + geom_smooth(method = "lm",fullrange = TRUE)

#log (pred mass / prey mass) by feeding interaction type
qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass), data = MyDF)
qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass), data = MyDF, geom = "jitter") #shows density of points more

#boxplots - by feeding interaction type
qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass), data = MyDF, geom = "boxplot")

#histogram
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "histogram", 
      fill = Type.of.feeding.interaction, binwidth = 1)
#show smoothed density for readability
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "density", 
      fill = Type.of.feeding.interaction)
#only outline
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "density", 
      colour = Type.of.feeding.interaction)


#multi faceted plot
qplot(log(Prey.mass/Predator.mass), facets = Type.of.feeding.interaction ~., data = MyDF, geom =  "density")

#logged axis
qplot(Prey.mass, Predator.mass, data = MyDF, log="xy")

#theme and labels
qplot(Prey.mass, Predator.mass, data = MyDF, log="xy",
      main = "Relation between predator and prey mass", 
      xlab = "Prey mass (g)", 
      ylab = "Predator mass (g)") + theme_light()

#save plot
pdf("../results/MyFirst-ggplot2-Figure.pdf")
print(qplot(Prey.mass, Predator.mass, data = MyDF,log="xy",
            main = "Relation between predator and prey mass", 
            xlab = "log(Prey mass) (g)", 
            ylab = "log(Predator mass) (g)") + theme_bw())
dev.off()


#use of geom to define graph type
# barplot
qplot(Predator.lifestage, data = MyDF, geom = "bar")
# violin plot
qplot(Predator.lifestage, log(Prey.mass), data = MyDF, geom = "violin")
# histogram
qplot(log(Predator.mass), data = MyDF, geom = "histogram")