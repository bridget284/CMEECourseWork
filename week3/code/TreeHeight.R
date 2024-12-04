# This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"

# function to measure tree heights, with arguments of distance from and angle to tree top
# returns the height of the tree
TreeHeight <- function(degrees, distance) {
  radians <- degrees * pi / 180
  height <- distance * tan(radians)
  print(paste("Tree height is:", height))
  
  return (height)
}

# example calculation
TreeHeight(37, 40)

# read in data of tree distance/angles and save this data, along with the tree heights
# found using function TreeHeight, to TreeHts.csv
data <- read.csv("../data/trees.csv")
data$Tree.Height.m <- TreeHeight(data$Angle.degrees, data$Distance.m)
write.csv(data, "../results/TreeHts.csv")
